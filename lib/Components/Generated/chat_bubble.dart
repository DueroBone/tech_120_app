import 'package:flutter/material.dart';

class ChatBubbleRaw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Expand the bubble to fill the parent
        Positioned.fill(
          child: Container(
            decoration: ShapeDecoration(
              color: const Color(0xFF4FA1FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        // Keep the small square anchored to the bottom-left
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: const Color(0xFF4FA1FF)),
          ),
        ),
      ],
    );
  }
}
