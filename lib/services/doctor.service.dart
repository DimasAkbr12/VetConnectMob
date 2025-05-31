import 'dart:convert';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DokterService {
  static const String baseUrl = 
      'https://vetconnectmob-production.up.railway.app/api';

  
  static Future<String?> getToken() async {
    final box = GetStorage();
    return box.read('token'); 
  }

  // Fetch semua dokter
  static Future<DokterResponse> getAllDokters() async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('Token not found. User might not be logged in.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/vets'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return DokterResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load dokters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getAllDokters: $e');
      throw Exception('Error fetching dokters: $e');
    }
  }

  // Fetch dokter untuk home page (hanya 5 dokter pertama)
  static Future<List<Dokter>> getDoktersForHome() async {
    try {
      final dokterResponse = await getAllDokters();
      
      if (dokterResponse.success && dokterResponse.data.isNotEmpty) {
        return dokterResponse.data.take(5).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error fetching dokters for home: $e');
    }
  }

  // Fetch detail dokter by ID (jika dibutuhkan)
  static Future<Dokter?> getDokterById(int id) async {
    try {
      final dokterResponse = await getAllDokters();
      
      if (dokterResponse.success) {
        return dokterResponse.data.firstWhere(
          (dokter) => dokter.id == id,
          orElse: () => throw Exception('Dokter not found'),
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching dokter detail: $e');
    }
  }
}
