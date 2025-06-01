import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/doctor.dart';
import 'package:flutter_application_1/services/doctor.service.dart';
import 'package:flutter_application_1/widgets/dokter_card.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  late Future<List<Dokter>> _doktersFuture;

  @override
  void initState() {
    super.initState();
    _doktersFuture = _fetchDokters();
  }

  Future<List<Dokter>> _fetchDokters() async {
    try {
      final response = await DokterService.getAllDokters();
      if (response.success) {
        return response.data;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching dokters: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Doctors',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search a Doctor',
                filled: true,
                fillColor: const Color.fromARGB(255, 235, 235, 235),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                // kamu bisa tambahkan fitur pencarian di sini jika ingin
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Dokter>>(
                future: _doktersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load doctors: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No doctors found.'));
                  } else {
                    final dokters = snapshot.data!;
                    return ListView.builder(
                      itemCount: dokters.length,
                      itemBuilder: (context, index) {
                        final dokter = dokters[index];
                        return DokterCard(
                          dokter: dokter,
                          isCompact: false,
                          onTap: () {
                            // TODO: Navigasi ke detail jika perlu
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (_) => DoctorDetailPage(dokter: dokter),
                            // ));
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
