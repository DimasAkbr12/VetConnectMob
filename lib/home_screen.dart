import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import halaman Sign In

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Abu-Abu dengan Sedikit Hijau)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD1D5D8), // Abu-abu terang
                  Color(0xFFB0C4B1), // Abu-abu dengan sedikit hijau
                  Color(0xFF497D74), // Hijau gelap di bawah
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Gambar Dokter Hewan
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80), // Sesuaikan posisi
              child: Image.asset(
                "assets/images/dokter.png", // Sesuaikan path gambar
                width: 250, // Ukuran gambar
              ),
            ),
          ),

          // Teks dan Tombol
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Teks Judul
                  const Text(
                    'Pelayanan Dokter Hewan\nEksklusif, Kapan Saja, di\nMana Saja',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tombol "Get Started"
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF497D74), // Warna hijau sesuai gambar
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
