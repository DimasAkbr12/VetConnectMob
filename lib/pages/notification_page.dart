import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      image: 'assets/doctor1.jpg',
      title: 'Need the Best Care for Your Pet?',
      time: '2 hours ago',
    ),
    NotificationItem(
      image: 'assets/doctor2.jpg',
      title:
          '20% discount if you stay on Saturday 27 November 2024 at Cerulean Hotel',
      time: '2 hours ago',
    ),
    NotificationItem(
      image: 'assets/booking_success.png',
      title: 'You have successfully booked a doctor.',
      time: '2 hours ago',
    ),
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        context: context,
      ),
      body:
          notifications.isEmpty
              ? _buildEmptyNotification()
              : _buildNotificationList(),
    );
  }

  Widget _buildEmptyNotification() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            "No Notifications Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You'll see updates here when you have notifications.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return _buildNotificationItem(notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem item) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(item.image),
      ),
      title: Text(item.title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        item.time,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
    );
  }
}

class NotificationItem {
  final String image;
  final String title;
  final String time;

  NotificationItem({
    required this.image,
    required this.title,
    required this.time,
  });
}
