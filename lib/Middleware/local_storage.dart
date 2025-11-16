import "package:tech_120_app/Middleware/authentication.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage2 {
  AuthToken? getAuthTokenFromStorage() {
    // TODO
  }

  void saveAuthTokenToStorage(AuthToken authToken) {
    // TODO
  }

  void clearAuthTokenFromStorage() {
    // TODO
  }
}

class ExampleLocalStorage {
  // ---- Singleton instance ----
  ExampleLocalStorage._privateConstructor();
  static final ExampleLocalStorage instance =
      ExampleLocalStorage._privateConstructor();

  // ---- Database reference ----
  Database? _db;

  // ---- Initialize database ----
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_storage.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT,
            avatar TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            senderId TEXT,
            receiverId TEXT,
            content TEXT,
            timestamp INTEGER
          );
        ''');
      },
    );
  }

  // ---- Example API methods ----

  Future<void> saveUser(String id, String name, String avatar) async {
    final db = await database;
    await db.insert('users', {
      'id': id,
      'name': name,
      'avatar': avatar,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    final db = await database;

    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) return null;
    return result.first;
  }

  Future<void> saveMessage(
    String sender,
    String receiver,
    String content,
  ) async {
    final db = await database;

    await db.insert('messages', {
      'senderId': sender,
      'receiverId': receiver,
      'content': content,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getMessages(
    String userA,
    String userB,
  ) async {
    final db = await database;

    return await db.query(
      'messages',
      where:
          '(senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?)',
      whereArgs: [userA, userB, userB, userA],
      orderBy: 'timestamp ASC',
    );
  }
}
