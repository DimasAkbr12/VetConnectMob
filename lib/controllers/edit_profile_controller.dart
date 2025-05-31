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
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var selectedImage = Rx<File?>(null);
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

  void pickImage(File image) {
    selectedImage.value = image;
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
        alamat: addressController.text,
        password: passwordController.text.isNotEmpty ? passwordController.text : null,
        passwordConfirmation: confirmPasswordController.text.isNotEmpty
            ? confirmPasswordController.text
            : null,
        profilePhoto: selectedImage.value,
      );

      final result = await http.Response.fromStream(response);
      final data = jsonDecode(result.body);

      if (result.statusCode == 200 && data['success'] == true) {
        Get.snackbar("Sukses", "Profil berhasil diperbarui");
        Navigator.pop(context, true);
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
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
