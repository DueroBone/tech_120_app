import 'dart:ui';

import 'package:tech_120_app/Middleware/models/auth_token.dart';

class User {
  final AuthToken authToken;
  final String name;
  final Image? avatar;
  final bool isMentor;

  User(this.authToken, this.name, this.avatar, this.isMentor);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      AuthToken(json['id'] as String),
      json['name'] as String,
      null,
      json['isMentor'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': authToken.token,
    'name': name,
    'isMentor': isMentor,
  };
}
