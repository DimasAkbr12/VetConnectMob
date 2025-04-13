import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/my_order_page.dart';
import 'package:flutter_application_1/pages/payment_page.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3,
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildMenuItem(
            icon: Icons.receipt_long,
            title: 'My Order',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrderPage()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.payment,
            title: 'Payment',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentPage()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
          ),
          const Spacer(),
          _buildLogoutButton(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
            'assets/images/dokter_detail.png',
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Pedri Gonzalez',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'PedriGo@gmail.com',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '+63 187231111',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route) => false);
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
