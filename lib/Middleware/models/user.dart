import 'dart:ui';

import 'package:tech_120_app/Middleware/authentication.dart';

class User {
  final AuthToken id;
  final String name;
  final Image? avatar;
  final bool isMentor;

  User(this.id, this.name, this.avatar, this.isMentor);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      AuthToken(json['id'] as String),
      json['name'] as String,
      null,
      json['isMentor'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id.token,
    'name': name,
    'isMentor': isMentor,
  };
}
