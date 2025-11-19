import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    User self,
    User otherUser,
  ) async {
    try {
      final response = await _networking.getList(
        '/messages',
        headers: {
          'Authorization': self.authToken.token,
          'Other-User-Id': otherUser.authToken.token,
        },
      );
      return null; // TODO
      // Return from one to three random messages for testing
    } catch (e) {
      // return null; // TODO
      return List.generate((1 + (DateTime.now().millisecondsSinceEpoch % 10)), (
        index,
      ) {
        final isFromCurrent =
            ((DateTime.now().millisecondsSinceEpoch + index) % 2 == 0);
        return Message(
          isFromCurrent,
          'Test message ${index + 1} to ${isFromCurrent ? 'other' : 'current'} user.',
          null,
          isFromCurrent ? getCurrentUserFromStorage()! : otherUser,
          isFromCurrent ? otherUser : getCurrentUserFromStorage()!,
          DateTime.now().subtract(Duration(minutes: index * 5)),
        );
      });
    }
  }

  // Send message JSON to server (for now forwards to networking).
  Future<void> sendMessageToServer(AuthToken authToken, Message message) async {
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
  Future<List<User>?> fetchContactsForUser(User user) async {
    // Generate 3 test users
    List<User> a = List<User>.generate(
      10,
      (index) => User(
        AuthToken('user_token_$index'),
        'User $index',
        Image.asset('assets/images/pic${index % 5}.jpg'),
        index % 2 == 0,
      ),
    );
    a.add(getCurrentUserFromStorage()!);
    // return a with a delay to simulate network
    await Future.delayed(const Duration(seconds: 1));
    return a;
    try {
      final response = await _networking.getList(
        '/users',
        headers: {'Authorization': user.authToken.token, 'Filter': 'contacts'},
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
