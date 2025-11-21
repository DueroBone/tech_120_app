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
  final GlobalKey _lastMessageKey = GlobalKey();
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
            // After messages are loaded, render them as a column so the
            // outer SingleChildScrollView (from MakeFullscreen) controls
            // scrolling. Attach a key to the last message so we can
            // scroll it into view after the frame.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              try {
                final ctx = _lastMessageKey.currentContext;
                if (ctx != null) {
                  Scrollable.ensureVisible(
                    ctx,
                    duration: const Duration(milliseconds: 250),
                    alignment: 1.0,
                  );
                }
              } catch (e) {
                // Ignore if ensureVisible fails for any reason.
              }
            });

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List<Widget>.generate(messages.length, (index) {
                  final message = messages[index];
                  var sentByCurrentUser =
                      message.sender.authToken == currentUser.authToken;
                  final bubble = ChatBubble(
                    message: message.text!,
                    isSentByCurrentUser: sentByCurrentUser,
                  );
                  if (index == messages.length - 1) {
                    return Container(key: _lastMessageKey, child: bubble);
                  }
                  return bubble;
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
