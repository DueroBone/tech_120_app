import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/home_page.dart';

// Basically just renames Iphone161 to HomePage for clarity
// This process is called wrapping
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Iphone161();
  }
}
