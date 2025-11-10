import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/smaller.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class SmallerView extends StatelessWidget {
  const SmallerView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Small Test", child: Smaller());
  }
}
