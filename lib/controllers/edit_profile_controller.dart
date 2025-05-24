import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/edit_profile_api_service.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  Future<void> updateProfile(BuildContext context) async {
    isLoading.value = true;
    try {
      final response = await EditProfileService.updateProfile(
        token: token,
        name: nameController.text,
        email: emailController.text,
        noTelp: phoneController.text,
        umur: int.tryParse(ageController.text),
        password: passwordController.text.isNotEmpty ? passwordController.text : null,
        passwordConfirmation: confirmPasswordController.text.isNotEmpty
            ? confirmPasswordController.text
            : null,
      );

      final result = await http.Response.fromStream(response);
      final data = jsonDecode(result.body);

      if (result.statusCode == 200 && data['success'] == true) {
        Get.snackbar("Sukses", "Profil berhasil diperbarui");
        Navigator.pop(context);
      } else {
        Get.snackbar("Gagal", data['message'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
