import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String doctorName;
  final double sessionFee;
  final double serviceFee;

  const PaymentPage({
    Key? key,
    required this.doctorName,
    required this.sessionFee,
    required this.serviceFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPayment = sessionFee + serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Row(
              children: [
                // Replace with doctor's image URL
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Dokter Hewan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Payment Details
            Text('Session fee 1 Meet: Rp ${sessionFee.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 16));
            Text('Service fee: Rp ${serviceFee.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 16));
            Text('Your Payment: Rp ${totalPayment.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
            
            const SizedBox(height: 20),

            // Payment Method
            const Text('Select Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Payment Method: e.g. QRIS
                _buildPaymentMethodButton('QRIS'),
                _buildPaymentMethodButton('MasterCard'),
              ],
            ),
            const Spacer(),

            // Pay & Confirm Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Payment Success Page (not implemented yet)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentSuccessPage(totalPayment: totalPayment)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF497D74),
                ),
                child: const Text(
                  'Pay & Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(String method) {
    return Row(
      children: [
        Switch(value: false, onChanged: (value) {}),
        Text(method),
      ],
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  final double totalPayment;

  const PaymentSuccessPage({Key? key, required this.totalPayment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 20),
            const Text(
              'Payment Success',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your payment has been successful, you can have a consultation session with your trusted doctor.',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}