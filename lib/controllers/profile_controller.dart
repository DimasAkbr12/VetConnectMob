import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final ProfileService _service = ProfileService();

  var isLoading = false.obs;
  var profileData = {}.obs;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    loadTokenAndProfile();
  }

  Future<void> loadTokenAndProfile() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    if (token.isNotEmpty) {
      await loadProfile();
    }
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final data = await _service.getProfile(token);
      profileData.value = data;
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
