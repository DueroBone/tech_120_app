import 'package:flutter/material.dart';

class ContactEntry extends StatefulWidget {
  const ContactEntry({super.key});

  @override
  State<ContactEntry> createState() => _ContactEntryState();
}

class _ContactEntryState extends State<ContactEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 30.0, color: Colors.white),
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            'Contact Name',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
