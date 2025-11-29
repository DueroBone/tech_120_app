import "package:tech_120_app/Middleware/local_storage.dart";

class AuthToken {
  final String token;

  AuthToken(this.token);
}

bool isIsAuthenticated(AuthToken? authToken) {
  return authToken != null && authToken.token.isNotEmpty;
}

Future<AuthToken?> getAuthToken() async {
  final storage = localStorage;
  return await storage.getAuthToken();
}

class AuthenticationMiddleware {}
