import "package:tech_120_app/Middleware/authentication.dart";
import "package:tech_120_app/Middleware/networking.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage2 {
  final NetworkingService _networking = NetworkingService();

  // Wrapper for networking - gets auth token from API
  Future<AuthToken?> getAuthTokenFromStorage() async {
    try {
      final response = await _networking.get('/auth/token');
      if (response['token'] != null) {
        return AuthToken(response['token'] as String);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Wrapper for networking - saves auth token to API
  Future<void> saveAuthTokenToStorage(AuthToken authToken) async {
    try {
      await _networking.post('/auth/token', body: {
        'token': authToken.token,
      });
    } catch (e) {
      // Handle error if needed
    }
  }

  // Wrapper for networking - clears auth token from API
  Future<void> clearAuthTokenFromStorage() async {
    try {
      await _networking.delete('/auth/token');
    } catch (e) {
      // Handle error if needed
    }
  }

  // Future method for local database implementation
  // To use local database instead of networking:
  // 1. Uncomment and implement these methods using sqflite
  // 2. Update the public methods above to call these instead of networking
  
  // Future<AuthToken?> _getAuthTokenFromLocalDb() async {
  //   // Implementation using sqflite
  //   return null;
  // }
  
  // Future<void> _saveAuthTokenToLocalDb(AuthToken authToken) async {
  //   // Implementation using sqflite
  // }
  
  // Future<void> _clearAuthTokenFromLocalDb() async {
  //   // Implementation using sqflite
  // }
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
