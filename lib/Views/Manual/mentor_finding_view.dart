import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/S-Mentor%20Finding/mentor_finding.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class MentorFindingView extends StatelessWidget {
  const MentorFindingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(child: MentorFinding());
  }
}