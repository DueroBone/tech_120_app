import 'package:flutter/material.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Views/Manual/Mentor/mentor_profile.dart';
// removed unused imports

class ContactEntry extends StatefulWidget {
  const ContactEntry({super.key, required this.user});

  final User user;

  @override
  State<ContactEntry> createState() => _ContactEntryState();
}

class _ContactEntryState extends State<ContactEntry> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 189, 189, 189),
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.blue,
                  child: widget.user.TEMPavatar == null
                      ? const Icon(Icons.person, size: 30.0, color: Colors.white)
                      : FutureBuilder<Widget?>(
                          future: widget.user.TEMPavatar,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const SizedBox(
                                width: 56.0,
                                height: 56.0,
                                child: Center(
                                  child: CircularProgressIndicator(strokeWidth: 2.0),
                                ),
                              );
                            }
                            final avatar = snapshot.data;
                            return avatar != null
                                ? ClipOval(
                                    child: SizedBox(
                                      width: 56.0,
                                      height: 56.0,
                                      child: avatar,
                                    ),
                                  )
                                : const Icon(Icons.person, size: 30.0, color: Colors.white);
                          },
                        ),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                widget.user.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MentorMessagingView(otherUser: widget.user);
            },
          ),
        );
      },
    );
  }
}
