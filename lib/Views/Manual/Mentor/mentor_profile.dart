import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/Mentor Messaging/Mentor_Messaging.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class MentorMessagingView extends StatefulWidget {
  final dynamic otherUser;
  const MentorMessagingView({super.key, required this.otherUser});

  @override
  State<MentorMessagingView> createState() => _MentorMessagingViewState();
}

class _MentorMessagingViewState extends State<MentorMessagingView> {
  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(
      title: "Messages",
      child: MessagingStudentSide(otherUser: widget.otherUser),
    );
  }
}
