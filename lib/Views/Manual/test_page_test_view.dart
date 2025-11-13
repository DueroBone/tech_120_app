import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/test_page_test.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

// Basically just renames Iphone161 to TestPageView for clarity
// This process is called wrapping
class TestPageTestView extends StatelessWidget {
  const TestPageTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Test Page View", child: Iphone161());
  }
}
