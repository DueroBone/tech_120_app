import 'package:flutter/material.dart';
import 'package:tech_120_app/Components/Generated/chat_bubble.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSentByCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByCurrentUser,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          // Optionally set a max width if you want the bubble constrained
          width: 300,
          height: 100,
          child: Stack(
            // alignment: Alignment.center,
            children: [
              if (widget.isSentByCurrentUser)
                Transform(
                  // mirror the bubble for current user
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14),
                  child: ChatBubbleRaw(),
                )
              else
                ChatBubbleRaw(),

              Center(
                // Center the text within the bubble
                child: Text(widget.message, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
