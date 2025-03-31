import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/article_page.dart';
import 'package:flutter_application_1/pages/doctor_list_page.dart';
import 'package:flutter_application_1/pages/report_page.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_1/pages/detail_dokter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _doctors = [
    {
      'name': 'Dr. Nallarasi',
      'specialization': 'Veterinarian',
      'image': 'assets/images/dokter_detail.png',
    },
    {
      'name': 'Drh. Joko Susanto',
      'specialization': 'Veterinarian',
      'image': 'assets/images/image.png',
    },
    {
      'name': 'Dr. Nallarasi',
      'specialization': 'Veterinarian',
      'image': 'assets/images/dokter_detail.png',
    },
    {
      'name': 'Drh. Joko Susanto',
      'specialization': 'Veterinarian',
      'image': 'assets/images/image.png',
    },
    {
      'name': 'Dr. Nallarasi',
      'specialization': 'Veterinarian',
      'image': 'assets/images/dokter_detail.png',
    },
    {
      'name': 'Drh. Joko Susanto',
      'specialization': 'Veterinarian',
      'image': 'assets/images/image.png',
    },
  ];

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
            const SizedBox(height: 20),
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
            const Text(
              'Service',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildServiceIcon(Icons.local_hospital, 'Doctors', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorListPage()),
                  );
                }),
                _buildServiceIcon(Icons.article_outlined, 'Article', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticlePage()),
                  );
                }),
                _buildServiceIcon(Icons.assignment_outlined, 'Report', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportsPage()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Doctor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DoctorListPage()),
                    );
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.grey, // Changed to gray
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _doctors.length,
                itemBuilder: (context, index) {
                  return _buildDoctorCard(
                    context,
                    _doctors[index]['name']!,
                    _doctors[index]['specialization']!,
                    _doctors[index]['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      ),
    );
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
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDoctorCard(
    BuildContext context,
    String name,
    String specialization,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailPage()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        elevation: 3, // Adds shadow effect
        color: const Color.fromARGB(
          255,
          253,
          253,
          253,
        ), // Updated doctor card color
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 120,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      specialization,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const Text(
                        '5.0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
