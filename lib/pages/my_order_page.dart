import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class MyOrderPage extends StatelessWidget {
  final int orderId;

  MyOrderPage({super.key, required this.orderId});

  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    controller.fetchOrder(orderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(ProfilePage());
          },
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final order = controller.order.value;
        if (order == null) {
          return Center(child: Text('Pesanan tidak ditemukan'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    order.namaDokter,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  _infoRow(Icons.calendar_today, 'Tanggal', order.tanggal),
                  _infoRow(
                    Icons.access_time,
                    'Jam',
                    '${order.jamMulai} - ${order.jamSelesai}',
                  ),
                  _infoRow(Icons.report_problem, 'Keluhan', order.keluhan),
                  _infoRow(
                    Icons.monetization_on,
                    'Harga',
                    'Rp${order.totalHarga}',
                  ),
                  _infoRow(Icons.verified, 'Status', order.status),
                  _infoRow(
                    Icons.payment,
                    'Pembayaran',
                    '${order.statusBayar} (${order.metodePembayaran})',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal[300], size: 20),
          SizedBox(width: 10),
          Text('$title:', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 6),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[800])),
          ),
        ],
      ),
    );
  }
}
