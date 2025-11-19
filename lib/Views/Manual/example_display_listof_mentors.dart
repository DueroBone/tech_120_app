import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/make_fullscreen.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';

class ExampleDisplayListofMentors extends StatefulWidget {
  const ExampleDisplayListofMentors({super.key});

  @override
  State<ExampleDisplayListofMentors> createState() =>
      _ExampleDisplayListofMentorsState();
}

class _ExampleDisplayListofMentorsState
    extends State<ExampleDisplayListofMentors> {
  @override
  Widget build(BuildContext context) {
    final currentUser = LocalStorage().getCurrentUserFromStorage();
    return MakeFullscreen(
      child: FutureBuilder<List<User>>(
        future: LocalStorage()
            .fetchContactsForUser(currentUser!)
            .then((list) => list ?? <User>[]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Loading mentors...");
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error loading mentors: ${snapshot.error}");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("No mentors found.");
            return const Center(child: Text('No mentors found.'));
          } else {
            print("Mentors loaded successfully.");
            final mentors = snapshot.data!;
            return ListView.builder(
              // When nested inside MakeFullscreen (which uses
              // SingleChildScrollView), the ListView would receive
              // unbounded height. Use `shrinkWrap` and disable internal
              // scrolling so the outer scroll view manages scrolling.
              itemCount: mentors.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final mentor = mentors[index];
                return ListTile(
                  title: Text(mentor.name),
                  leading: Icon(Icons.person),
                  subtitle: Text(mentor.isMentor ? 'Mentor' : 'Mentee'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
