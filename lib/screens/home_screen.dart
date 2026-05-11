import 'package:flutter/material.dart';
import '../widgets/header_menu_button.dart';
import '../api/food_api.dart';
import '../types/types.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> foods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    final fetchedFoods = await FoodApi.getPopularFoods();
    if (mounted) {
      setState(() {
        foods = fetchedFoods;
        isLoading = false;
      });
    }
  }

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
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: const Icon(Icons.person_outline, size: 24),
                      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Pizza', 'Fast Food', 'Chicken', 'Snacks', 'Sauce'].map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/list', arguments: cat),
                          child: Column(
                            children: [
                              Text(
                                cat,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 3, 
                                width: 24, 
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF4B3A),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
                // Horizontal Scroll Food
                SizedBox(
                  height: 320,
                  child: isLoading 
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF4B3A)))
                    : foods.isEmpty
                      ? const Center(child: Text('No food available'))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            final food = foods[index];
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/detail', arguments: food),
                              child: Container(
                                width: 220,
                                margin: const EdgeInsets.only(right: 20, bottom: 20, top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Positioned(
                                      top: -20,
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 20,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: food.image.isNotEmpty 
                                            ? Image.network(food.image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, size: 50))
                                            : const Icon(Icons.fastfood, size: 50),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 130.0, left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          Text(
                                            food.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            '\$${food.price}',
                                            style: const TextStyle(
                                              color: Color(0xFFFF4B3A),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
