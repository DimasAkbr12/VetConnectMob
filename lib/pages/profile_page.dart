import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = ProfileController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTokenAndProfile();
  }

  Future<void> _loadTokenAndProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      controller.token = token;
      await controller.loadProfile();
      setState(() {
        isLoading = false;
      });
    } else {
      // Jika token tidak ada, arahkan ke login
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (_) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
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
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, '/edit-profile').then((value) {
                setState(() {
                  isLoading = true;
                });
                controller.loadProfile().then((_) {
                  setState(() {
                    isLoading = false;
                  });
                });
              });
            },
          ),
          const Spacer(),
          _buildLogoutButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileHeader({
    required String name,
    required String email,
    required String phone,
  }) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/dokter_detail.png'),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          phone,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (_) => false);
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
