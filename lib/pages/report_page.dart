import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
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
      bottomNavigationBar: Container(
        color: const Color.fromARGB(
          255,
          253,
          253,
          253,
        ), // Matches the doctor card
        child: const CustomBottomNavBar(currentIndex: 1),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConsultationCard(
              date: "02 October 2024",
              doctorName: "Drh. Joko Susanto",
              doctorRole: "Veterinarian",
              statusText: "Completed",
              statusColor: Colors.green,
              iconColor: Colors.green,
              onDownload: () => _downloadReport(context),
            ),
            const SizedBox(height: 16),
            _buildConsultationCard(
              date: "02 October 2024",
              doctorName: "Drh. Joko Susanto",
              doctorRole: "Veterinarian",
              statusText: "Pending Payment",
              statusColor: Colors.orange,
              iconColor: Colors.orange,
              onDownload: () => _showPaymentPrompt(context),
            ),
            const SizedBox(height: 16),
            _buildConsultationCard(
              date: "02 October 2024",
              doctorName: "Drh. Joko Susanto",
              doctorRole: "Veterinarian",
              statusText: "Cancelled",
              statusColor: Colors.red,
              iconColor: Colors.red,
              onDownload: () => _showCancelledMessage(context),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadReport(BuildContext context) {
    // Simulate download
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading report...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPaymentPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Payment Required'),
            content: const Text(
              'Please complete your payment to access this report.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showCancelledMessage(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancelled Consultation'),
            content: const Text(
              'No report available for cancelled consultations.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Widget _buildConsultationCard({
    required String date,
    required String doctorName,
    required String doctorRole,
    required String statusText,
    required Color statusColor,
    required Color iconColor,
    required VoidCallback onDownload,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Icon(Icons.pets, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Consultation with",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctorRole,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    onPressed: onDownload,
                    icon: Icon(Icons.file_download_outlined, color: iconColor),
                    splashRadius: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
