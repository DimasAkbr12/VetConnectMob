import 'dart:io';
import 'package:http/http.dart' as http;

class EditProfileService {
  static const String baseUrl = 'https://vetconnectmob-production.up.railway.app/api';

  static Future<http.StreamedResponse> updateProfile({
    required String token,
    required String name,
    required String email,
    String? noTelp,
    int? umur,
    String? password,
    String? passwordConfirmation,
  }) async {
    var uri = Uri.parse('$baseUrl/user/profile');
    var request = http.MultipartRequest('PUT', uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = name;
    request.fields['email'] = email;
    if (noTelp != null) request.fields['no_telp'] = noTelp;
    if (umur != null) request.fields['umur'] = umur.toString();
    if (password != null) request.fields['password'] = password;
    if (passwordConfirmation != null) request.fields['password_confirmation'] = passwordConfirmation;

    return request.send();
  }
}
