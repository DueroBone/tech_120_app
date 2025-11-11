import 'package:flutter/material.dart';

class MakeFullscreen extends StatelessWidget {
  const MakeFullscreen({
    Key? key,
    this.title = 'Peer Mentor Match', // default value
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Center(
          child: child,
        ), // Centers the generated content because it does not perfectly fill the screen
      ), // Makes the page scrollable in case the content is taller than the screen
    );
  }
}
