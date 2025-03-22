import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: const Center(child: Text('Reports Page')),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        context: context,
      ),
    );
  }
}
