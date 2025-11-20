import sqlite3
import os


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
                imagePath TEXT
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
        cursor.execute("PRAGMA table_info(Messages);")
        cols = [row[1] for row in cursor.fetchall()]
        if "imagePath" not in cols:
            cursor.execute("ALTER TABLE Messages ADD COLUMN imagePath TEXT;")
            print("Added imagePath column to Messages table")
            conn.commit()
        conn.close()
        print(f"Database already exists at {db_path}")


if __name__ == "__main__":
    # When run directly create the DB inside the backend folder by default
    default_path = os.path.join(os.path.dirname(__file__), "database.db")
    create_database(default_path)
