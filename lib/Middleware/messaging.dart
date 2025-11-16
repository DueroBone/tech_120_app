import 'dart:ui';
import 'package:tech_120_app/Middleware/authentication.dart';

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
}

class User {
  final String id;
  final String name;
  final Image? avatar;

  User(this.id, this.name, this.avatar);
}

Future<List<Message>> fetchMessages(
  AuthToken authToken,
  String otherUserId,
) async {
  // TODO
  return [];
}

Future<bool> sendMessage(
  AuthToken authToken,
  String receiverId,
  Message message,
) async {
  // TODO
  return false; // No errors
}

Future<List<User>> fetchAllUsers(AuthToken authToken) async {
  // TODO
  return [];
}
