import "package:tech_120_app/Middleware/local_storage.dart";

class AuthToken {
  final String token;

  AuthToken(this.token);
}

bool isIsAuthenticated(AuthToken authToken) {
  // TODO: Placeholder for actual authentication logic
  return true;
}

class AuthenticationMiddleware {}
