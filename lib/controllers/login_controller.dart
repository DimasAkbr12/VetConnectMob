import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/login_api_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  final box = GetStorage(); // Inisialisasi GetStorage

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email dan Password wajib diisi');
      return;
    }

    isLoading.value = true;

    try {
      final response = await LoginService.login(email, password);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        final token = data['token'];
        print('Login sukses, token: $token');

        // Simpan token ke GetStorage
        await box.write('token', token);

        Get.snackbar('Sukses', 'Berhasil login');
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final message = data['message'] ?? 'Login gagal';
        print('Gagal login: $message');
        Get.snackbar('Login Gagal', message);
      }
    } catch (e) {
      print('Exception saat login: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
