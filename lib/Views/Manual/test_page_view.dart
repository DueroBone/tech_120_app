import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/test_page.dart';

// Basically just renames Iphone161 to TestPageView for clarity
// This process is called wrapping
class TestPageView extends StatelessWidget {
  const TestPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tech 120 Test Page')),
      body: Center(
        child: Iphone161(),
      ), // Centers the generated content because it does not perfectly fill the screen
    );
  }
}
