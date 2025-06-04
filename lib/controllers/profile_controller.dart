import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/profile_service.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final ProfileService _service = ProfileService();
  final box = GetStorage();

  var isLoading = false.obs;
  var profileData = {}.obs;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    loadTokenAndProfile();
  }

  Future<void> loadTokenAndProfile() async {
    await loadToken();
    if (token.isNotEmpty) {
      await loadProfile();
    } else {
      debugPrint('Token tidak tersedia!');
    }
  }

  Future<void> loadToken() async {
    token = box.read('token') ?? '';
    debugPrint('Token dimuat: $token');
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
