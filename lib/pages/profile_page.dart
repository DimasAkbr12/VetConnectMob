import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/my_order_page.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  int? bookingId;

  @override
  void initState() {
    super.initState();
    _loadBookingId();
  }

Future<void> _loadBookingId() async {
  final prefs = await SharedPreferences.getInstance();
  final storedBookingId = prefs.getInt('bookingId'); // ambil sebagai int
  setState(() {
    bookingId = storedBookingId;
  });
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final data = controller.profileData;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(
              name: data['name'] ?? '-',
              email: data['email'] ?? '-',
              phone: data['no_telp'] ?? '-',
              fotoUrl: data['foto'],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/edit-profile',
                );
                if (result == true) {
                  controller.loadProfile();
                }
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.book_online_outlined),
              title: const Text('My Order', style: TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (bookingId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrderPage(orderId: bookingId!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No order found')),
                  );
                }
              },
            ),
            const Spacer(),
            _buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      );
    });
  }

  Widget _buildProfileHeader({
    required String name,
    required String email,
    required String phone,
    String? fotoUrl,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: fotoUrl != null && fotoUrl.isNotEmpty
              ? NetworkImage(fotoUrl)
              : const AssetImage('assets/images/profile.jpg') as ImageProvider,
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(phone, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        if (context.mounted) {
          Get.offAllNamed('/sign-in');
        }
      },
      child: const Text(
        'Log Out',
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
