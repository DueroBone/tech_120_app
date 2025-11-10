import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/fullscreen.dart';
import 'package:tech_120_app/Views/Manual/test_page_view.dart';
import 'package:tech_120_app/Views/Manual/chat_view.dart';
import 'package:tech_120_app/Views/Manual/sign_up_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(
      title: "Tech 120 App",
      child: Column(
        children: [
          ElevatedButton(
            // Button labeled 'Go to Test Page'
            onPressed: () {
              Navigator.push(
                // Adds a new page on top of the current one
                context,
                MaterialPageRoute(builder: (context) => const TestPageView()),
              );
              print("Going to Test Page");
            },
            child: const Text('Go to Test Page'), // What is in the button
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatView()),
              );
            },
            child: const Text('Go to Chat Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpView()),
              );
              print("Going to Sign Up Page");
            },
            child: const Text('Sign Up Page'),
          ),
        ],
      ),
    );
  }
}
