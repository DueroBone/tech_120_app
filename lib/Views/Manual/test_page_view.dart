import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/test_page.dart';
import 'package:tech_120_app/Views/fullscreen.dart';

// Basically just renames Iphone161 to TestPageView for clarity
// This process is called wrapping
class TestPageView extends StatelessWidget {
  const TestPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Test Page View", child: Iphone161());
  }
}
