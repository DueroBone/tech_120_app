import 'dart:ui';
import 'package:tech_120_app/Middleware/authentication.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';
import 'package:tech_120_app/Middleware/current_user.dart';
import 'package:tech_120_app/Middleware/models/user.dart';

class Message {
  final bool isText;
  final String? text;
  final Image? image;
  final DateTime timestamp;
  final String senderId;
  final String receiverId;

  Message(
    this.isText,
    this.text,
    this.image,
    this.senderId,
    this.receiverId,
    this.timestamp,
  );

  Map<String, dynamic> toJson() {
    return {
      'isText': isText,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['isText'] as bool,
      json['text'] as String?,
      null,
      json['senderId'] as String,
      json['receiverId'] as String,
      DateTime.parse(json['timestamp'] as String),
    );
  }
}

// `User` moved to `lib/Middleware/models/user.dart`.

Future<List<Message>> fetchMessages(
  AuthToken authToken,
  String otherUserId,
) async {
  final localStore = LocalMessageStore();
  try {
    final response = await localStore.fetchMessagesFromStorage(
      authToken,
      otherUserId,
    );
    return response
        .map((json) => Message.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    return [];
  }
}

Future<bool> sendMessage(
  AuthToken authToken,
  String receiverId,
  Message message,
) async {
  final localStore = LocalMessageStore();
  try {
    return await localStore.sendMessageToServer(authToken, message.toJson());
  } catch (e) {
    return false;
  }
}

Future<List<User>> fetchAllUsers(AuthToken authToken) async {
  final localStore = LocalMessageStore();
  try {
    final response = await localStore.fetchAllUsersFromStorage(authToken);
    return response
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    return [];
  }
}

User? getCurrentUser() {
  return currentUserStore.user;
}
