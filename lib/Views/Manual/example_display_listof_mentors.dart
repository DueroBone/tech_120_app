import 'package:flutter/material.dart';
import 'package:tech_120_app/Components/Manual/contact_entry.dart';
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
  String? _selectedMajor;

  List<String> getUniqueMajors(List<User> users) {
    final majors = users.map((user) => user.major).toSet().toList();
    majors.sort();
    return majors;
  }

  List<User> filterMentorsByMajor(List<User> mentors) {
    if (_selectedMajor == null || _selectedMajor == 'All') {
      return mentors;
    }
    return mentors.where((mentor) => mentor.major == _selectedMajor).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = localStorage.getCurrentUserFromStorage();
    return MakeFullscreen(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [const Color(0xFF253067), const Color(0xFF8A4EBC)],
          ),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: FutureBuilder<List<User>>(
          future: localStorage
              .fetchContactsForUser(currentUser!)
              .then((list) => list ?? <User>[]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Loading mentors...");
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error loading mentors: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              print("No mentors found.");
              return const Center(child: Text('No mentors found.'));
            } else {
              print("Mentors loaded successfully.");
              final mentors = snapshot.data!;
              final uniqueMajors = getUniqueMajors(mentors);
              final filteredMentors = filterMentorsByMajor(mentors);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Filter by Major',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: _selectedMajor,
                        items: [
                          DropdownMenuItem<String>(
                            value: 'All',
                            child: Text('All'),
                          ),
                          ...uniqueMajors.map(
                            (major) => DropdownMenuItem<String>(
                              value: major,
                              child: Text(major),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedMajor = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: filteredMentors.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final mentor = filteredMentors[index];
                        return ContactEntry(user: mentor);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
