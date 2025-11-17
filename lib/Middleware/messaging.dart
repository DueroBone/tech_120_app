import 'dart:ui';
import 'package:tech_120_app/Middleware/authentication.dart';
import 'package:tech_120_app/Middleware/networking.dart';

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

class User {
  final String id;
  final String name;
  final Image? avatar;

  User(this.id, this.name, this.avatar);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as String,
      json['name'] as String,
      null,
    );
  }
}

Future<List<Message>> fetchMessages(
  AuthToken authToken,
  String otherUserId,
) async {
  final networking = NetworkingService();
  try {
    final response = await networking.getList(
      '/messages/$otherUserId',
      headers: {'Authorization': 'Bearer ${authToken.token}'},
    );
    return response.map((json) => Message.fromJson(json as Map<String, dynamic>)).toList();
  } catch (e) {
    return [];
  }
}

Future<bool> sendMessage(
  AuthToken authToken,
  String receiverId,
  Message message,
) async {
  final networking = NetworkingService();
  try {
    await networking.post(
      '/messages',
      headers: {'Authorization': 'Bearer ${authToken.token}'},
      body: message.toJson(),
    );
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<User>> fetchAllUsers(AuthToken authToken) async {
  final networking = NetworkingService();
  try {
    final response = await networking.getList(
      '/users',
      headers: {'Authorization': 'Bearer ${authToken.token}'},
    );
    return response.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
  } catch (e) {
    return [];
  }
}
