import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../services/edit_profile_api_service.dart';

class EditProfileController extends GetxController {
  // Text Editing Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final box = GetStorage();

  var isLoading = false.obs;
  var selectedImage = Rx<File?>(null);
  String token = '';

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    token = box.read('token') ?? '';
    debugPrint('Token dimuat: $token');
  }

  void pickImage(File image) {
    selectedImage.value = image;
  }

  Future<void> updateProfile(BuildContext context) async {
    isLoading.value = true;

    try {
      final response = await EditProfileService.updateProfile(
        token: token,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        noTelp: phoneController.text.trim(),
        umur: int.tryParse(ageController.text.trim()),
        alamat: addressController.text.trim(),
        password: passwordController.text.isNotEmpty
            ? passwordController.text
            : null,
        passwordConfirmation: confirmPasswordController.text.isNotEmpty
            ? confirmPasswordController.text
            : null,
        profilePhoto: selectedImage.value,
      );

      final result = await http.Response.fromStream(response);

      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);

        if (data['success'] == true) {
          Get.snackbar("Sukses", "Profil berhasil diperbarui",
              snackPosition: SnackPosition.BOTTOM);
          Navigator.pop(context, true);
        } else {
          Get.snackbar(
            "Gagal",
            data['message'] ?? 'Gagal memperbarui profil',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        debugPrint("Status code: ${result.statusCode}");
        debugPrint("Response body:\n${result.body}");

        Get.snackbar("Gagal", "Update gagal: ${result.statusCode}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      debugPrint("Exception during profile update: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          snackPosition: SnackPosition.BOTTOM);
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
