import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../models/doctor.dart';
import '../services/doctor.service.dart';
import '../pages/article_page.dart';
import '../pages/doctor_list_page.dart';
import '../pages/report_page.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileController = Get.find<ProfileController>();
  List<Dokter> dokters = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    profileController.loadTokenAndProfile();
    _loadDokters();
  }

  Future<void> _loadDokters() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await DokterService.getDoktersForHome();
      setState(() {
        dokters = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Widget _buildServiceIcon(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: const Color(0xFF497D74),
            radius: 25,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildDoctorCard(BuildContext context, Dokter dokter) {
    return GestureDetector(
      onTap: () {
        // Implementasi navigasi ke detail dokter jika sudah tersedia
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        elevation: 3,
        color: const Color.fromARGB(255, 253, 253, 253),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(
                  dokter.foto,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dokter.nama, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text('Veterinarian', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(
                      dokter.deskripsi,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 18),
                  SizedBox(height: 4),
                  Text('5.0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search doctor, drugs, articles...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildServiceIcon(Icons.local_hospital, 'Doctors', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  DoctorListPage()));
                }),
                _buildServiceIcon(Icons.article_outlined, 'Article', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  ArticlePage()));
                }),
                _buildServiceIcon(Icons.assignment_outlined, 'Report', () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsPage()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Top Doctor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>  DoctorListPage()));
                  },
                  child: const Text('See All', style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                              const SizedBox(height: 16),
                              const Text('Failed to load doctors'),
                              ElevatedButton(onPressed: _loadDokters, child: const Text('Retry')),
                            ],
                          ),
                        )
                      : dokters.isEmpty
                          ? const Center(child: Text('No doctors available'))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: dokters.length,
                              itemBuilder: (context, index) => _buildDoctorCard(context, dokters[index]),
                            ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0, backgroundColor: Color.fromARGB(255, 253, 253, 253)),
    );
  }
}
