import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/profile_service.dart';

class ProfileController {
  final ProfileService _service = ProfileService();

  /// Menyimpan status loading
  bool isLoading = false;

  /// Menyimpan data profil
  Map<String, dynamic> profileData = {};

  /// Token autentikasi
  String? token;

  /// Ambil data profil dari service
  Future<void> loadProfile() async {
    if (token == null) return;

    try {
      isLoading = true;
      final data = await _service.getProfile(token!);
      profileData = data;
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      isLoading = false;
    }
  }
}
