import 'package:flutter/material.dart';

class ChatBubbleRaw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 166,
          height: 77,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 166,
                  height: 77,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF4FA1FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 45,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: const Color(0xFF4FA1FF)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
