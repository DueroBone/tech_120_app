import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Manual/test_page_view.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold enlarges to fit the screen and provides structure
      appBar: AppBar(title: const Text('Tech 120 Root')), // Top bar with title
      body: ElevatedButton(
        // Button labeled 'Go to Test Page'
        onPressed: () {
          Navigator.push(
            // Adds a new page on top of the current one
            context,
            MaterialPageRoute(builder: (context) => const TestPageView()),
          );
        },
        child: const Text('Go to Test Page'), // What is in the button
      ),
    );
  }
}
