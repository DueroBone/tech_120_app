import 'package:flutter/foundation.dart';
import 'package:tech_120_app/Middleware/models/user.dart';
import 'package:tech_120_app/Middleware/local_storage.dart';
import 'package:tech_120_app/Middleware/networking.dart';

class CurrentUserStore {
  CurrentUserStore._();
  static final CurrentUserStore _instance = CurrentUserStore._();
  factory CurrentUserStore() => _instance;

  final ValueNotifier<User?> notifier = ValueNotifier<User?>(null);

  User? get user => notifier.value;
  void setUser(User? u) => notifier.value = u;
  void clear() => notifier.value = null;
}

final currentUserStore = CurrentUserStore();

/// Initialize the current user at app startup.
///
/// Steps:
/// - Load `AuthToken` from `SharedPreferences` via `LocalStorage2`.
/// - If present, call the API `GET /users/me` with `Authorization: Bearer <token>`.
/// - Parse returned JSON into `User` and set `currentUserStore`.
///
/// Returns `true` if a user was successfully loaded and set, otherwise `false`.
Future<bool> initializeCurrentUser() async {
  final local = LocalStorage();
  final authToken = await local.getAuthToken();
  if (authToken == null) return false;

  final networking = NetworkingService();
  try {
    final Map<String, dynamic> resp = await networking.get(
      '/users/me',
      headers: {'Authorization': 'Bearer ${authToken.token}'},
    );

    // Convert API response to User model and set global store.
    final user = User.fromJson(resp);
    currentUserStore.setUser(user);
    return true;
  } catch (e) {
    return false;
  }
}
