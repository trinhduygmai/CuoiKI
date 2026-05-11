import 'package:flutter/material.dart';
import '../widgets/header_menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderMenuButton(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/cart'),
                      child: const Icon(Icons.shopping_cart_outlined, size: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Delicious\nfood for you',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 32),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.black54),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Popular Foods',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // List of foods would go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
