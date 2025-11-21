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
      // Parse response (expected a List of message JSON objects)
      final List<Message> messages = [];
      for (final item in response) {
        try {
          final Map<String, dynamic> m = Map<String, dynamic>.from(item);
          final String senderId = m['senderId'] as String;
          final String receiverId = m['receiverId'] as String;
          final bool isText = (m['isText'] == true) || (m['isText'] == 1);
          final String? text = m['text'] as String?;
          final String? imagePath = m['imagePath'] as String?;
          final DateTime timestamp = DateTime.parse(m['timestamp'] as String);

          final User sender = (senderId == self.authToken.token)
              ? self
              : otherUser;
          final User receiver = (receiverId == self.authToken.token)
              ? self
              : otherUser;

          messages.add(
            Message(isText, text, imagePath, sender, receiver, timestamp),
          );
        } catch (e) {
          // skip malformed message
          continue;
        }
      }
      return messages;
    } catch (e, st) {
      print('Error fetching messages, returning test messages: $e\n$st');
      // For testing, return some fake messages
      await Future.delayed(const Duration(seconds: 1));
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
      // On error, fallback to returning an empty list
      // return <Message>[];
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
    } catch (e, st) {
      // TODO: Handle error if needed
      print('Error sending message to server: $e\n$st');
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
      final List<User> users = [];
      for (final item in response) {
        try {
          final Map<String, dynamic> u = Map<String, dynamic>.from(item);
          users.add(User.fromJson(u));
        } catch (e) {
          continue;
        }
      }
      return users;
    } catch (e, st) {
      print('Error fetching all users, returning null: $e\n$st');
      return null;
    }
  }

  /// Returns the users that the current user has as contacts.
  Future<List<User>?> fetchContactsForUser(User user) async {
    try {
      final response = await _networking.getList(
        '/users',
        headers: {'Authorization': user.authToken.token, 'Filter': 'contacts'},
      );
      final List<User> users = [];
      for (final item in response) {
        try {
          final Map<String, dynamic> u = Map<String, dynamic>.from(item);
          users.add(User.fromJson(u));
        } catch (e, st) {
          print('Error parsing user from JSON: $e\n$st');
          continue;
        }
      }
      return users;
    } catch (e, st) {
      // Generate 3 test users
      print('Error fetching contacts, returning test users: $e\n$st');
      List<User> a = List<User>.generate(
        10,
        (index) => User(
          AuthToken('user_token_$index'),
          'User $index',
          Image.asset('assets/images/pic${index % 5}.jpg'),
          null,
          index % 2 == 0,
        ),
      );
      a.add(getCurrentUserFromStorage()!);
      // return a with a delay to simulate network
      await Future.delayed(const Duration(seconds: 1));
      return a;
    }
  }

  User? getCurrentUserFromStorage() {
    return currentUserStore.user;
  }
}
