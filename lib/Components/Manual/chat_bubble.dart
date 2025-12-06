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
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Row(
          children: [
            if (widget.isSentByCurrentUser) const Expanded(child: SizedBox()),
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    if (widget.isSentByCurrentUser)
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: ChatBubbleRaw(),
                      )
                    else
                      ChatBubbleRaw(
                        bubbleColor: Color.fromARGB(255, 200, 200, 200),
                      ),
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.message,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
