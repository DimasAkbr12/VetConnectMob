import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/edit_profile_api_service.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  final isLoading = false.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listeners to validate form
    nameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
    ageController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    isFormValid.value = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  void updateProfile(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final ageText = ageController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validation
    if (name.isEmpty || email.isEmpty || phone.isEmpty || ageText.isEmpty || 
        password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua field wajib diisi');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password dan konfirmasi password tidak sama');
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null || age <= 0) {
      Get.snackbar('Error', 'Umur harus berupa angka yang valid');
      return;
    }

    isLoading.value = true;

    try {
      final response = await EditProfileService.updateProfile(
        name: name,
        email: email,
        noTelp: phone,
        umur: age,
        password: password,
        passwordConfirmation: confirmPassword,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Update profile sukses');
        Get.snackbar('Sukses', 'Profile berhasil diupdate');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final message = data['message'] ?? 'Update profile gagal';
        print('Gagal update profile: $message');
        Get.snackbar('Update Gagal', message);
      }
    } catch (e) {
      print('Exception saat update profile: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
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