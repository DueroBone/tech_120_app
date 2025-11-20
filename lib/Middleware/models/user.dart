import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:tech_120_app/Middleware/models/auth_token.dart';

class User {
  final AuthToken authToken;
  final String name;
  final Widget? TEMPavatar;
  final String? imagePath;
  final bool isMentor;

  User(this.authToken, this.name, this.TEMPavatar, this.imagePath, this.isMentor);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      AuthToken(json['id'] as String),
      json['name'] as String,
      null,
      json['imagePath'] as String?,
      json['isMentor'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': authToken.token,
    'name': name,
    'isMentor': isMentor,
  };
}
