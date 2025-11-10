import 'package:flutter/material.dart';

class MakeFullscreen extends StatelessWidget {
  const MakeFullscreen({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: child,
      ), // Centers the generated content because it does not perfectly fill the screen
    );
  }
}
