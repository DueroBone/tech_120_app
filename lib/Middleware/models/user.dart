import 'package:flutter/widgets.dart';
import 'package:tech_120_app/Middleware/models/auth_token.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';

class User {
  final AuthToken authToken;
  final String name;
  final Future<Widget?>? TEMPavatar;
  final String? imagePath;
  final bool isMentor;
  final String bio;
  final String major;

  User(
    this.authToken,
    this.name,
    this.TEMPavatar,
    this.imagePath,
    this.isMentor,
    this.bio,
    this.major,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    final String? imgPath = json['imagePath'] as String?;
    final LocalStorage storage = LocalStorage();
    return User(
      AuthToken(json['id'] as String),
      json['name'] as String,
      storage.getUserAvatarFromStorage(imgPath),
      imgPath,
      json['isMentor'] as bool,
      (json['bio'] as String?) ?? '',
      (json['major'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': authToken.token,
    'name': name,
    'isMentor': isMentor,
    'bio': bio,
    'major': major,
  };
}
