import "package:tech_120_app/Middleware/local_storage.dart";

class AuthToken {
  final String token;

  AuthToken(this.token);
}

bool isIsAuthenticated(AuthToken? authToken) {
  return true;
}

AuthToken? getAuthToken() {
  LocalStorage2 storage = LocalStorage2();
  return storage.getAuthTokenFromStorage();
}

class AuthenticationMiddleware {}
