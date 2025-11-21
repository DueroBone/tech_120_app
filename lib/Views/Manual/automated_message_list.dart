import 'package:flutter/material.dart';
import 'package:tech_120_app/Components/Manual/chat_bubble.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';
import 'package:tech_120_app/Middleware/messaging.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';

class AutomatedMessageList extends StatefulWidget {
  const AutomatedMessageList({super.key, required this.otherUser});
  final User otherUser;

  @override
  State<AutomatedMessageList> createState() => _AutomatedMessageListState();
}

class _AutomatedMessageListState extends State<AutomatedMessageList> {
  @override
  Widget build(BuildContext context) {
    final currentUser = LocalStorage().getCurrentUserFromStorage();
    return MakeFullscreen(
      title: widget.otherUser.name,
      child: FutureBuilder<List<Message>?>(
        future: LocalStorage().fetchMessagesToUser(
          currentUser!,
          widget.otherUser,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Loading messages...");
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error loading messages: ${snapshot.error}");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("No messages found.");
            return const Center(child: Text('No messages found.'));
          } else {
            print("Messages loaded successfully.");
            final messages = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                // When nested inside MakeFullscreen (which uses
                // SingleChildScrollView), the ListView would receive
                // unbounded height. Use `shrinkWrap` and disable internal
                // scrolling so the outer scroll view manages scrolling.
                itemCount: messages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final message = messages[index];
                  var sentByCurrentUser =
                      message.sender.authToken == currentUser.authToken;
                  return ChatBubble(
                    message: message.text!,
                    isSentByCurrentUser: sentByCurrentUser,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
