import 'package:flutter/material.dart';
import 'package:tech_120_app/Views/bottom_tabs.dart';
import 'package:tech_120_app/Middleware/current_user.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Middleware/models/auth_token.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';

class LoginPlaceholder extends StatelessWidget {
  const LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorage();
    storage.clearAuthToken(); // TODO: Check if needed
    return Scaffold(
      appBar: AppBar(title: const Text('Login (placeholder)')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login screen placeholder',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Create a fake auth token and user for testing.
                final testToken = AuthToken('123');

                // Persist token so initializer can pick it up if needed.
                await storage.saveAuthToken(testToken);
                final testUser = User(
                  testToken,
                  'Test User',
                  Future<Widget?>.value(
                    Image.asset('assets/images/blank_profile_pic.png'),
                  ),
                  null,
                  false,
                  'Test bio',
                );
                currentUserStore.setUser(testUser);

                // Navigate into the main app scaffold so bottom tabs are present.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BottomTabs()),
                );
              },
              child: const Text('Continue to App'),
            ),
          ],
        ),
      ),
    );
  }
}
