import 'package:flutter/material.dart';
import 'package:tech_120_app/Components/Generated/chat_bubble.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  const ChatBubble({Key? key, required this.message}) : super(key: key);

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
          // width: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ChatBubbleRaw(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(widget.message, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
