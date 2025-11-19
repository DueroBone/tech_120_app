import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/Generated/Mentor%20Messaging/Mentor_Messaging.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class StudentMessagesView extends StatefulWidget {
  const StudentMessagesView({super.key});

  @override
  State<StudentMessagesView> createState() => _StudentMessagesViewState();
}

class _StudentMessagesViewState extends State<StudentMessagesView> {
  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(child: MessagingStudentSide());
  }
}