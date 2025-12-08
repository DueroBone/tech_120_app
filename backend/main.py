import os
import uuid
import sqlite3
import logging
import re
from typing import Optional
from fastapi import FastAPI, UploadFile, File, HTTPException, Request, Form
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from starlette.exceptions import HTTPException as StarletteHTTPException

UPLOAD_DIR = os.path.join(os.path.dirname(__file__), "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)

app = FastAPI(title="tech_120_app backend")

# Serve uploaded files at /uploads
app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")

# Constants for validation
MAX_TEXT_LENGTH = 10000
MAX_BIO_LENGTH = 2000
MAX_MAJOR_LENGTH = 200
MAX_NAME_LENGTH = 100
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10MB


def sanitize_string(text: str, max_length: int) -> str:
    """Sanitize and validate string input."""
    if not isinstance(text, str):
        raise ValueError("Input must be a string")
    # Strip leading/trailing whitespace
    text = text.strip()
    # Limit length
    if len(text) > max_length:
        raise ValueError(f"Input exceeds maximum length of {max_length}")
    # Remove null bytes and control characters except newlines/tabs
    text = re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]", "", text)
    return text


def validate_user_id(user_id: str) -> str:
    """Validate user ID format."""
    if not user_id or not isinstance(user_id, str):
        raise ValueError("Invalid user ID")
    user_id = user_id.strip()
    # Limit length and basic character validation
    if len(user_id) > 255 or len(user_id) < 1:
        raise ValueError("Invalid user ID length")
    # Remove dangerous characters
    if re.search(r"[\x00-\x1f\x7f]", user_id):
        raise ValueError("Invalid characters in user ID")
    return user_id


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException):
    """Custom exception handler to avoid leaking sensitive information."""
    # Log the actual error for debugging
    logging.error(f"HTTP {exc.status_code} error: {exc.detail}")

    # Return generic messages for server errors
    if exc.status_code >= 500:
        return JSONResponse(
            status_code=exc.status_code,
            content={"detail": "An internal server error occurred"},
        )
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail},
    )


@app.exception_handler(Exception)
async def general_exception_handler(request: Request, exc: Exception):
    """Catch-all exception handler to prevent information leakage."""
    # Log the full error for debugging
    logging.exception(f"Unhandled exception: {str(exc)}")

    # Return generic error message
    return JSONResponse(
        status_code=500,
        content={"detail": "An internal server error occurred"},
    )


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
    try:
        # Basic validation: only images allowed
        content_type = file.content_type or ""
        if content_type.split("/")[0] != "image":
            raise HTTPException(
                status_code=400, detail="Only image uploads are allowed"
            )

        # Read contents with size limit
        contents = await file.read(MAX_FILE_SIZE + 1)
        if len(contents) > MAX_FILE_SIZE:
            raise HTTPException(
                status_code=400, detail="File size exceeds maximum allowed"
            )

        # Validate file has content
        if len(contents) == 0:
            raise HTTPException(status_code=400, detail="Empty file not allowed")

        # Generate a safe random filename preserving extension
        original_name = file.filename or ""
        ext = os.path.splitext(original_name)[1] if original_name else ""
        # Sanitize extension
        ext = re.sub(r"[^a-zA-Z0-9.]", "", ext)[:10]
        if not ext:
            ext = ".jpg"  # Default extension
        filename = f"{uuid.uuid4().hex}{ext}"
        dest_path = os.path.join(UPLOAD_DIR, filename)

        # Save to disk
        try:
            with open(dest_path, "wb") as f:
                f.write(contents)
        except Exception as e:
            logging.error(f"Failed to save file: {str(e)}")
            raise HTTPException(status_code=500, detail="Failed to save file")
    except HTTPException:
        raise
    except Exception as e:
        logging.exception(f"Upload error: {str(e)}")
        raise HTTPException(status_code=500, detail="Upload failed")
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
    try:
        if authorization.lower().startswith("bearer "):
            token = authorization.split(" ", 1)[1]
        else:
            token = authorization
        # Basic validation
        return validate_user_id(token)
    except Exception as e:
        logging.warning(f"Token extraction failed: {str(e)}")
        return None


@app.on_event("startup")
def startup_db():
    # Ensure database and tables exist
    db_path = os.path.join(os.path.dirname(__file__), "database.db")
    create_database(db_path)


@app.get("/users/me")
async def get_me(request: Request):
    try:
        auth = request.headers.get("authorization")
        token = extract_token(auth)
        if not token:
            raise HTTPException(
                status_code=401, detail="Missing or invalid authorization token"
            )

        conn = db_connect()
        cur = conn.cursor()
        cur.execute(
            "SELECT id, name, isMentor, bio, major, imagePath FROM Users WHERE id = ?",
            (token,),
        )
        row = cur.fetchone()
        if not row:
            # Create a placeholder user so client can proceed
            default_name = f"User {token[:8]}"
            cur.execute(
                "INSERT INTO Users (id, name, isMentor, bio, major, imagePath) VALUES (?, ?, ?, ?, ?, ?)",
                (token, default_name, 0, "", "", None),
            )
            conn.commit()
            user = {
                "id": token,
                "name": default_name,
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
    except HTTPException:
        raise
    except Exception as e:
        logging.exception(f"Error in get_me: {str(e)}")
        raise HTTPException(
            status_code=500, detail="Failed to retrieve user information"
        )


@app.put("/users/me")
async def update_me(request: Request):
    """Update the current user's profile (bio, major, imagePath).

    Requires an Authorization header containing the user id (token).
    Accepts JSON body with optional 'bio' and 'major' fields.
    """
    try:
        auth = request.headers.get("authorization")
        token = extract_token(auth)
        if not token:
            raise HTTPException(
                status_code=401, detail="Missing or invalid authorization token"
            )

        body = await request.json()

        # Sanitize inputs
        bio = None
        major = None
        image_path = None

        if "bio" in body and body["bio"] is not None:
            bio = sanitize_string(body["bio"], MAX_BIO_LENGTH)
        if "major" in body and body["major"] is not None:
            major = sanitize_string(body["major"], MAX_MAJOR_LENGTH)
        if "imagePath" in body and body["imagePath"] is not None:
            image_path = sanitize_string(body["imagePath"], 500)

        conn = db_connect()
        cur = conn.cursor()

        # Ensure user exists
        cur.execute("SELECT 1 FROM Users WHERE id = ?", (token,))
        if not cur.fetchone():
            default_name = f"User {token[:8]}"
            cur.execute(
                "INSERT INTO Users (id, name, isMentor, bio, major, imagePath) VALUES (?, ?, ?, ?, ?, ?)",
                (token, default_name, 0, bio or "", major or "", image_path),
            )
        else:
            # Only update provided fields
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
    except HTTPException:
        raise
    except ValueError as e:
        raise HTTPException(status_code=400, detail="Invalid input data")
    except Exception as e:
        logging.exception(f"Error in update_me: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to update user information")


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
    try:
        auth = request.headers.get("authorization")
        other_id = request.headers.get("other-user-id")
        token = extract_token(auth)

        if not token:
            raise HTTPException(
                status_code=401, detail="Missing or invalid authorization token"
            )
        if not other_id:
            raise HTTPException(status_code=400, detail="Other-User-Id header required")

        # Validate other_id
        try:
            other_id = validate_user_id(other_id)
        except ValueError:
            raise HTTPException(status_code=400, detail="Invalid Other-User-Id")

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
    except HTTPException:
        raise
    except Exception as e:
        logging.exception(f"Error in get_messages: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to retrieve messages")


@app.post("/messages")
async def post_message(request: Request):
    try:
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

        # Validate IDs
        try:
            sender_id = validate_user_id(sender_id)
            receiver_id = validate_user_id(receiver_id)
        except ValueError:
            raise HTTPException(status_code=400, detail="Invalid user ID format")

        # Sanitize text content
        if text is not None:
            text = sanitize_string(text, MAX_TEXT_LENGTH)

        # Sanitize image path
        if image_path is not None:
            image_path = sanitize_string(image_path, 500)

        # Validate timestamp format (basic check)
        if not isinstance(timestamp, str) or len(timestamp) > 100:
            raise HTTPException(status_code=400, detail="Invalid timestamp format")
        timestamp = sanitize_string(timestamp, 100)

        conn = db_connect()
        cur = conn.cursor()

        # Ensure sender and receiver exist
        for uid in (sender_id, receiver_id):
            cur.execute("SELECT 1 FROM Users WHERE id = ?", (uid,))
            if not cur.fetchone():
                default_name = f"User {uid[:8]}"
                cur.execute(
                    "INSERT INTO Users (id, name, isMentor) VALUES (?, ?, ?)",
                    (uid, default_name, 0),
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
    except HTTPException:
        raise
    except ValueError as e:
        raise HTTPException(status_code=400, detail="Invalid input data")
    except Exception as e:
        logging.exception(f"Error in post_message: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to create message")


if __name__ == "__main__":
    import uvicorn

    # Configure logging
    log_config = uvicorn.config.LOGGING_CONFIG
    log_config["handlers"]["file"] = {
        "class": "logging.FileHandler",
        "filename": os.path.join(os.path.dirname(__file__), "uvicorn.log"),
        "formatter": "default",
    }
    log_config["loggers"]["uvicorn"]["handlers"] = ["default", "file"]
    log_config["loggers"]["uvicorn.access"]["handlers"] = ["access", "file"]

    uvicorn.run(app, host="127.0.0.1", port=8011, log_config=log_config)
