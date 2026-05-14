import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 60),
              ),
              const SizedBox(height: 48),
              const Text(
                'Payment Success!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order is being processed and will be delivered soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<GlobalProvider>(context, listen: false).clearCart();
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4B3A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
