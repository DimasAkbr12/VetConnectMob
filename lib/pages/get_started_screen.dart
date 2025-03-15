import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
                  Color.fromARGB(255, 10, 89, 59), // Abu-abu dengan sedikit hijau
                  Color.fromARGB(71, 2, 50, 21), // Hijau gelap di bawah
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Gambar Dokter Hewan
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 180), // Sesuaikan posisi
              child: Image.asset(
                "assets/images/dokter.jpg", // Sesuaikan path gambar
                width: 450, // Ukuran gambar
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
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF497D74), // Warna hijau sesuai gambar
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
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