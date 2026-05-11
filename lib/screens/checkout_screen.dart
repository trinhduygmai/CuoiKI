import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            _buildSectionTitle('Address details', 'change'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Marvis Igwe', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Divider(height: 24),
                  Text('Km 5.5 Limbe Road, Beside University of Buea, Cameroon', 
                    style: TextStyle(color: Colors.black54, height: 1.5),
                  ),
                  SizedBox(height: 12),
                  Text('+237 671334455', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildSectionTitle('Delivery method', ''),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                   _buildRadioOption('Door delivery', true),
                   const Divider(height: 24),
                   _buildRadioOption('Pick up', false),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 17)),
                const Text('\$23,000', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/success'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4B3A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Proceed to Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(action, style: const TextStyle(color: Color(0xFFFF4B3A))),
      ],
    );
  }

  Widget _buildRadioOption(String label, bool selected) {
    return Row(
      children: [
        Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: const Color(0xFFFF4B3A),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 17)),
      ],
    );
  }
}
