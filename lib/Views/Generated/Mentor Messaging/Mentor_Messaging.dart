import 'package:flutter/material.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';
import 'package:tech_120_app/Middleware/messaging.dart' as msg_model;
import 'package:tech_120_app/Middleware/models/user.dart';

class MessagingStudentSide extends StatefulWidget {
  final User? otherUser;
  const MessagingStudentSide({Key? key, this.otherUser}) : super(key: key);

  @override
  _MessagingStudentSideState createState() => _MessagingStudentSideState();
}

class _MessagingStudentSideState extends State<MessagingStudentSide> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final local = LocalStorage();
    final sender = local.getCurrentUserFromStorage();
    final receiver = widget.otherUser;
    final text = _messageController.text.trim();

    if (sender == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No current user')));
      return;
    }
    if (receiver == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No recipient selected')));
      return;
    }
    if (text.isEmpty) {
      return;
    }

    final message = msg_model.Message(true, text, null, sender, receiver, DateTime.now());
    try {
      await local.sendMessageToServer(sender.authToken, message);
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Message sent')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sending message')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 420,
          height: 666,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [const Color(0xFF253067), const Color(0xFF8A4EBC)],
            ),
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: -21,
                top: 553,
                child: Container(
                  width: 438,
                  height: 117,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 438,
                          height: 117,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Message input + send button
              Positioned(
                left: 16,
                top: 576,
                child: Container(
                  width: 380,
                  height: 58,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF81CBF3),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _messageController,
                              decoration: InputDecoration.collapsed(hintText: 'Message'),
                              textInputAction: TextInputAction.send,
                              onFieldSubmitted: (_) => _sendMessage(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 56,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF253067),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 298,
                top: 650.24,
                child: Opacity(
                  opacity: 0.90,
                  child: Container(
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0)
                      ..rotateZ(-1.57),
                    width: 74.24,
                    height: 95,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/74x95"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 172,
                top: 47,
                child: Container(
                  width: 213,
                  height: 56,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 213,
                          height: 56,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF81CBF3),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 115,
                child: Container(
                  width: 213,
                  height: 87,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 213,
                          height: 87,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 165,
                top: 213,
                child: Container(
                  width: 220,
                  height: 128,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 220,
                          height: 128,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF81CBF3),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 353,
                child: Container(
                  width: 201,
                  height: 51,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 201,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 79,
                top: -33,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(3.14),
                  width: 54,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset('assets/images/pic1.jpg').image,
                      fit: BoxFit.contain,
                    ),
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
