import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/Mentor Messaging/Mentor_Messaging.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class MentorMessagingView extends StatelessWidget {
  const MentorMessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Messages", child: MessagingStudentSide());
  }
}
