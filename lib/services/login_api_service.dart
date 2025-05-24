import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = 'https://vetconnectmob-production.up.railway.app/api';

  static Future<http.Response> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      return response;
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
