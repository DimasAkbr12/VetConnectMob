import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfileService {
  static const String baseUrl = 'https://vetconnectmob-production.up.railway.app/api';

  static Future<http.Response> updateProfile({
    required String name,
    required String email,
    required String noTelp,
    required int umur,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/profile"), // Sesuaikan endpoint jika berbeda
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'no_telp': noTelp,
          'umur': umur,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      ).timeout(const Duration(seconds: 10));

      return response;
    } catch (e) {
      throw Exception('Update profile error: $e');
    }
  }
}