import "package:tech_120_app/Middleware/authentication.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_120_app/Middleware/networking.dart';

// Note: Local storage wrapper for messages/users. Currently these methods
// forward to the networking layer (no real local DB) so messaging code can
// be switched to use local storage later without changing public APIs.

class LocalStorage2 {
  // Uses Flutter's SharedPreferences to persist a single short token string.

  // Get the auth token from local storage (SharedPreferences).
  Future<AuthToken?> getAuthTokenFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null && token.isNotEmpty) {
        return AuthToken(token);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Save the auth token to local storage (SharedPreferences).
  Future<void> saveAuthTokenToStorage(AuthToken authToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', authToken.token);
    } catch (e) {
      // Handle error if needed
    }
  }

  // Clear the auth token from local storage (SharedPreferences).
  Future<void> clearAuthTokenFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    } catch (e) {
      // Handle error if needed
    }
  }
}

class LocalMessageStore {
  final NetworkingService _networking = NetworkingService();

  // Return raw list JSON for messages for the given other user.
  Future<List<dynamic>> fetchMessagesFromStorage(
    AuthToken authToken,
    String otherUserId,
  ) async {
    try {
      final response = await _networking.getList(
        '/messages/$otherUserId',
        headers: {'Authorization': 'Bearer ${authToken.token}'},
      );
      return response;
    } catch (e) {
      return <dynamic>[];
    }
  }

  // Send message JSON to server (for now forwards to networking).
  Future<bool> sendMessageToServer(
    AuthToken authToken,
    Map<String, dynamic> messageJson,
  ) async {
    try {
      await _networking.post(
        '/messages',
        headers: {'Authorization': 'Bearer ${authToken.token}'},
        body: messageJson,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Return raw list JSON for users.
  Future<List<dynamic>> fetchAllUsersFromStorage(AuthToken authToken) async {
    try {
      final response = await _networking.getList(
        '/users',
        headers: {'Authorization': 'Bearer ${authToken.token}'},
      );
      return response;
    } catch (e) {
      return <dynamic>[];
    }
  }

  Map<String, dynamic>? getCurrentUserFromStorage() {
    // For now, return null as no local storage is implemented.
    return null;
  }
}
