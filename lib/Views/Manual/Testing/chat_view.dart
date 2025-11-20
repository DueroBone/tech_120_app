import 'package:flutter/material.dart';
import 'package:tech_120_app/Components/Manual/chat_bubble.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 756,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatView()),
                    );
                  },
                  child: ChatBubble(
                    message: "Hello!",
                    isSentByCurrentUser: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: ChatBubble(
                    message: "Goodbye!",
                    isSentByCurrentUser: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return MakeFullscreen(title: "Chat View", child: const ChatContent());
  }
}
