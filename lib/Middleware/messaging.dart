// images are represented by server-side paths/URLs (imagePath)
import 'package:tech_120_app/Middleware/models/auth_token.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';
import 'package:tech_120_app/Middleware/current_user.dart';
import 'package:tech_120_app/Middleware/models/user.dart';

class Message {
  final bool isText;
  final String? text;
  final String? imagePath;
  final DateTime timestamp;
  final User sender;
  final User receiver;

  Message(
    this.isText,
    this.text,
    this.imagePath,
    this.sender,
    this.receiver,
    this.timestamp,
  );

  Map<String, dynamic> toJson() {
    return {
      'isText': isText,
      'text': text,
      'imagePath': imagePath,
      'senderId': sender.authToken.token,
      'receiverId': receiver.authToken.token,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // factory Message.fromJson(Map<String, dynamic> json) {
  //   return Message(
  //     json['isText'] as bool,
  //     json['text'] as String?,
  //     null,
  //     json['sender'] as String,
  //     json['receiver'] as String,
  //     DateTime.parse(json['timestamp'] as String),
  //   );
  // }
}
