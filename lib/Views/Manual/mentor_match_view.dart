import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/mentor_match.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class MentorMatchView extends StatelessWidget {
  const MentorMatchView({super.key});
  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Mentor Match", child: MentorMatch());
  }
}
