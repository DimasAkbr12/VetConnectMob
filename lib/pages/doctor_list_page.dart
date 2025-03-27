import 'package:flutter/material.dart';

class DoctorListPage extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {'name': 'Dr. Pawan', 'rating': 5.0, 'image': 'assets/images/dokter6.jpg'},
    {'name': 'Dr. Wanitha', 'rating': 5.0, 'image': 'assets/images/dokter2.png'},
    {'name': 'Dr. Udara', 'rating': 5.0, 'image': 'assets/images/dokter3.jpg'},
    {'name': 'Dr. Surya', 'rating': 5.0, 'image': 'assets/images/dokter4.jpg'},
  ];

  DoctorListPage({super.key});

  Widget buildDoctorCard(String name, double rating, String image) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4, // Adds shadow effect
      color: const Color.fromARGB(255, 253, 253, 253), // Slightly gray background for each card
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 120,
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(image),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Experienced professional in veterinary medicine.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text(
                      '$rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: Text(
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
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search a Doctor',
                filled: true,
                fillColor: const Color.fromARGB(255, 235, 235, 235),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: doctors
                      .map((doctor) => buildDoctorCard(
                            doctor['name'],
                            doctor['rating'],
                            doctor['image'],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}