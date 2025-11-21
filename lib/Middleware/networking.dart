import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkingService {
  static final NetworkingService _instance = NetworkingService._internal();
  factory NetworkingService() => _instance;
  NetworkingService._internal();

  // Base URL for API - can be configured
  // Default to HTTP (backend runs without TLS locally). If you're running
  // the Android emulator, use 'http://10.0.2.2:8000' when calling
  // `NetworkingService().setBaseUrl(...)` from your app startup.
  String baseUrl = 'http://127.0.0.1:8000';

  // Configure base URL
  void setBaseUrl(String url) {
    baseUrl = url;
  }

  // GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw NetworkException(
          'GET request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('GET request failed: $e', 0);
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final defaultHeaders = {'Content-Type': 'application/json', ...?headers};

      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw NetworkException(
          'POST request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('POST request failed: $e', 0);
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final defaultHeaders = {'Content-Type': 'application/json', ...?headers};

      final response = await http.put(
        url,
        headers: defaultHeaders,
        body: body != null ? json.encode(body) : null,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw NetworkException(
          'PUT request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('PUT request failed: $e', 0);
    }
  }

  // DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.delete(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return {'success': true};
        }
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw NetworkException(
          'DELETE request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('DELETE request failed: $e', 0);
    }
  }

  // GET request that returns a list
  Future<List<dynamic>> getList(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw NetworkException(
          'GET request failed with status: ${response.statusCode}',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException('GET request failed: $e', 0);
    }
  }
}

class NetworkException implements Exception {
  final String message;
  final int statusCode;

  NetworkException(this.message, this.statusCode);

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}
