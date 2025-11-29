import os
import uuid
import sqlite3
from typing import Optional
from fastapi import FastAPI, UploadFile, File, HTTPException, Request, Form
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles

UPLOAD_DIR = os.path.join(os.path.dirname(__file__), "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)

app = FastAPI(title="tech_120_app backend")

# Serve uploaded files at /uploads
app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")


@app.get("/health")
async def health():
    return {"status": "ok"}


def create_database(db_path="database.db"):
    """Creates a SQLite database with predefined tables if it doesn't exist."""
    if not os.path.exists(db_path):
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        # Create Users table
        cursor.execute(
            """
            CREATE TABLE Users (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                isMentor INTEGER NOT NULL DEFAULT 0,
                imagePath TEXT,
                bio TEXT,
                major TEXT
            );
            """
        )

        # Create Messages table (includes imagePath for uploaded images)
        cursor.execute(
            """
            CREATE TABLE Messages (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                isText INTEGER NOT NULL,
                text TEXT,
                imagePath TEXT,
                timestamp TEXT NOT NULL,
                senderId TEXT NOT NULL,
                receiverId TEXT NOT NULL,
                FOREIGN KEY (senderId) REFERENCES Users(id) ON DELETE CASCADE,
                FOREIGN KEY (receiverId) REFERENCES Users(id) ON DELETE CASCADE
            );
            """
        )

        # Helpful indexes
        cursor.execute("CREATE INDEX idx_messages_timestamp ON Messages(timestamp);")
        cursor.execute("CREATE INDEX idx_messages_sender ON Messages(senderId);")
        cursor.execute("CREATE INDEX idx_messages_receiver ON Messages(receiverId);")

        conn.commit()
        conn.close()
        print(f"Database created at {db_path}")
    else:
        # Ensure existing DB has the expected schema (add imagePath to Messages if missing)
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        # Ensure expected optional columns exist on existing tables
        cursor.execute("PRAGMA table_info(Messages);")
        cols = [row[1] for row in cursor.fetchall()]
        if "imagePath" not in cols:
            cursor.execute("ALTER TABLE Messages ADD COLUMN imagePath TEXT;")
            print("Added imagePath column to Messages table")

        cursor.execute("PRAGMA table_info(Users);")
        user_cols = [row[1] for row in cursor.fetchall()]
        if "major" not in user_cols:
            cursor.execute("ALTER TABLE Users ADD COLUMN major TEXT;")
            print("Added major column to Users table")
            conn.commit()
        conn.close()
        print(f"Database already exists at {db_path}")


@app.post("/upload")
async def upload_image(request: Request, file: UploadFile = File(...)):
    """Accept only an image file, save it to the uploads folder, and
    return the absolute URL clients can use to fetch it.
    """
    # Basic validation: only images allowed
    content_type = file.content_type or ""
    if content_type.split("/")[0] != "image":
        raise HTTPException(status_code=400, detail="Only image uploads are allowed")

    # Read contents (small files expected). You can add streaming if needed.
    contents = await file.read()
    # Generate a safe random filename preserving extension
    original_name = file.filename or ""
    ext = os.path.splitext(original_name)[1] if original_name else ""
    filename = f"{uuid.uuid4().hex}{ext}"
    dest_path = os.path.join(UPLOAD_DIR, filename)

    # Save to disk
    try:
        with open(dest_path, "wb") as f:
            f.write(contents)
    except Exception:
        await file.close()
        raise HTTPException(status_code=500, detail="Failed to save uploaded file")
    finally:
        await file.close()

    # Build absolute URL clients can use
    base = str(request.base_url).rstrip("/")
    url = f"{base}/uploads/{filename}"

    return JSONResponse({"imagePath": url, "filename": filename})


def db_connect():
    db_path = os.path.join(os.path.dirname(__file__), "database.db")
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    return conn


def extract_token(authorization: Optional[str]) -> Optional[str]:
    if not authorization:
        return None
    if authorization.lower().startswith("bearer "):
        return authorization.split(" ", 1)[1]
    return authorization


@app.on_event("startup")
def startup_db():
    # Ensure database and tables exist
    db_path = os.path.join(os.path.dirname(__file__), "database.db")
    create_database(db_path)


@app.get("/users/me")
async def get_me(request: Request):
    auth = request.headers.get("authorization")
    token = extract_token(auth)
    if not token:
        raise HTTPException(status_code=401, detail="Missing Authorization token")

    conn = db_connect()
    cur = conn.cursor()
    cur.execute(
        "SELECT id, name, isMentor, bio, major, imagePath FROM Users WHERE id = ?",
        (token,),
    )
    row = cur.fetchone()
    if not row:
        # Create a placeholder user so client can proceed
        cur.execute(
            "INSERT INTO Users (id, name, isMentor, bio, major, imagePath) VALUES (?, ?, ?, ?, ?, ?)",
            (token, f"User {token}", 0, "", "", None),
        )
        conn.commit()
        user = {
            "id": token,
            "name": f"User {token}",
            "isMentor": False,
            "bio": "",
            "major": "",
            "imagePath": None,
        }
    else:
        user = {
            "id": row[0],
            "name": row[1],
            "isMentor": bool(row[2]),
            "bio": row[3],
            "major": row[4],
            "imagePath": row[5],
        }
    conn.close()
    return user


@app.put("/users/me")
async def update_me(request: Request):
    """Update the current user's profile (bio, major, imagePath).

    Requires an Authorization header containing the user id (token).
    Accepts JSON body with optional 'bio' and 'major' fields.
    """
    auth = request.headers.get("authorization")
    token = extract_token(auth)
    if not token:
        raise HTTPException(status_code=401, detail="Missing Authorization token")

    body = await request.json()
    bio = body.get("bio")
    major = body.get("major")
    image_path = body.get("imagePath")

    conn = db_connect()
    cur = conn.cursor()

    # Ensure user exists
    cur.execute("SELECT 1 FROM Users WHERE id = ?", (token,))
    if not cur.fetchone():
        cur.execute(
            "INSERT INTO Users (id, name, isMentor, bio, major, imagePath) VALUES (?, ?, ?, ?, ?, ?)",
            (token, f"User {token}", 0, bio or "", major or "", image_path),
        )
    else:
        # Only update provided fields (use COALESCE so NULL doesn't overwrite existing values)
        if bio is not None:
            cur.execute("UPDATE Users SET bio = ? WHERE id = ?", (bio, token))
        if major is not None:
            cur.execute("UPDATE Users SET major = ? WHERE id = ?", (major, token))
        if image_path is not None:
            cur.execute(
                "UPDATE Users SET imagePath = ? WHERE id = ?", (image_path, token)
            )

    conn.commit()
    # Return the updated user record
    cur.execute(
        "SELECT id, name, isMentor, bio, major, imagePath FROM Users WHERE id = ?",
        (token,),
    )
    row = cur.fetchone()
    user = {
        "id": row[0],
        "name": row[1],
        "isMentor": bool(row[2]),
        "bio": row[3],
        "major": row[4],
        "imagePath": row[5],
    }
    conn.close()
    return user


@app.get("/users")
async def list_users(request: Request):
    # Optional auth header allowed but not required for listing in this simple API
    conn = db_connect()
    cur = conn.cursor()
    cur.execute("SELECT id, name, isMentor, bio, major, imagePath FROM Users")
    rows = cur.fetchall()
    users = []
    for r in rows:
        users.append(
            {
                "id": r[0],
                "name": r[1],
                "isMentor": bool(r[2]),
                "bio": r[3],
                "major": r[4],
                "imagePath": r[5],
            }
        )
    conn.close()
    return users


@app.get("/messages")
async def get_messages(request: Request):
    auth = request.headers.get("authorization")
    other_id = request.headers.get("other-user-id")
    token = extract_token(auth)
    if not token or not other_id:
        raise HTTPException(
            status_code=400, detail="Authorization and Other-User-Id headers required"
        )

    print(f"Fetching messages between {token} and {other_id}")

    conn = db_connect()
    cur = conn.cursor()
    cur.execute(
        """
        SELECT id, isText, text, imagePath, timestamp, senderId, receiverId
        FROM Messages
        WHERE (senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)
        ORDER BY timestamp ASC
        """,
        (token, other_id, other_id, token),
    )
    rows = cur.fetchall()
    print(f"Fetched {len(rows)} messages")
    messages = []
    for r in rows:
        messages.append(
            {
                "id": r[0],
                "isText": bool(r[1]),
                "text": r[2],
                "imagePath": r[3],
                "timestamp": r[4],
                "senderId": r[5],
                "receiverId": r[6],
            }
        )
    conn.close()
    return messages


@app.post("/messages")
async def post_message(request: Request):
    auth = request.headers.get("authorization")
    token = extract_token(auth)
    body = await request.json()

    # Accept both 'senderId' from body and Authorization header; prefer Authorization
    sender_id = token or body.get("senderId")
    receiver_id = body.get("receiverId")
    is_text = bool(body.get("isText"))
    text = body.get("text")
    image_path = body.get("imagePath")
    timestamp = body.get("timestamp")

    if not sender_id or not receiver_id or not timestamp:
        raise HTTPException(
            status_code=400, detail="senderId, receiverId and timestamp required"
        )

    conn = db_connect()
    cur = conn.cursor()

    # Ensure sender and receiver exist
    for uid in (sender_id, receiver_id):
        cur.execute("SELECT 1 FROM Users WHERE id = ?", (uid,))
        if not cur.fetchone():
            cur.execute(
                "INSERT INTO Users (id, name, isMentor) VALUES (?, ?, ?)",
                (uid, f"User {uid}", 0),
            )

    cur.execute(
        "INSERT INTO Messages (isText, text, imagePath, timestamp, senderId, receiverId) VALUES (?, ?, ?, ?, ?, ?)",
        (1 if is_text else 0, text, image_path, timestamp, sender_id, receiver_id),
    )
    conn.commit()
    msg_id = cur.lastrowid
    conn.close()

    return {
        "id": msg_id,
        "isText": is_text,
        "text": text,
        "imagePath": image_path,
        "timestamp": timestamp,
        "senderId": sender_id,
        "receiverId": receiver_id,
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8011)
