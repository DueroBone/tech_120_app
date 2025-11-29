import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/E-Sign Up/signup_page.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Sign Up", child: SignUp());
  }
}
