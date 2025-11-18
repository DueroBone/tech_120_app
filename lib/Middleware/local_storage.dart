import "package:tech_120_app/Middleware/models/auth_token.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_120_app/Middleware/messaging.dart';
import 'package:tech_120_app/Middleware/networking.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Middleware/current_user.dart';

// Note: Local storage wrapper for messages/users. Currently these methods
// forward to the networking layer (no real local DB) so messaging code can
// be switched to use local storage later without changing public APIs.

class LocalStorage {
  static final NetworkingService _networking = NetworkingService();

  // ============= Auth Token Storage =============
  // Uses Flutter's SharedPreferences to persist a single short token string.
  // Get the auth token from local storage (SharedPreferences).
  Future<AuthToken?> getAuthToken() async {
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
  Future<void> saveAuthToken(AuthToken authToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', authToken.token);
    } catch (e) {
      // Handle error if needed
    }
  }

  // Clear the auth token from local storage (SharedPreferences).
  Future<void> clearAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    } catch (e) {
      // Handle error if needed
    }
  }

  // ============= Messages =============
  // Return raw list JSON for messages for the given other user.
  Future<List<Message>?> fetchMessagesToUser(
    // Remove ?
    AuthToken authToken,
    User otherUser,
  ) async {
    try {
      final response = await _networking.getList(
        '/messages',
        headers: {'Authorization': authToken.token,
            'Other-User-Id': otherUser.authToken.token},
      );
      return null; // TODO
    } catch (e) {
      return null; // TODO
    }
  }

  // Send message JSON to server (for now forwards to networking).
  Future<void> sendMessageToServer(
    AuthToken authToken,
    Message message,
  ) async {
    try {
      await _networking.post(
        '/messages',
        headers: {'Authorization': authToken.token},
        body: message.toJson(),
      );
    } catch (e) {
      // TODO: Handle error if needed
    }
  }

  // ============= Users =============
  /// Return raw list JSON for users.
  Future<List<User>?> fetchAllUsersFromStorage(AuthToken authToken) async {
    try {
      final response = await _networking.getList(
        '/users',
        headers: {'Authorization': authToken.token},
      );
      return null; // TODO
    } catch (e) {
      return null; // TODO
    }
  }

  /// Returns the users that the current user has as contacts.
  Future<List<User>?> fetchContactsForUser(AuthToken authToken) async {
    try {
      final response = await _networking.getList(
        '/users',
        headers: {
          'Authorization': authToken.token,
          'Filter': 'contacts',
        },
      );
      return null; // TODO
    } catch (e) {
      return null; // TODO
    }
  }

  User? getCurrentUserFromStorage() {
    return currentUserStore.user;
  }
}
