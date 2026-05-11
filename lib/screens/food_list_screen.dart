import 'package:flutter/material.dart';
import '../api/food_api.dart';
import '../types/types.dart';

class FoodListScreen extends StatefulWidget {
  final String category;

  const FoodListScreen({super.key, required this.category});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<Food> foods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    final fetchedFoods = await FoodApi.getFoodsByCategory(widget.category);
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Spacer(),
                  Text(
                    widget.category,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            Expanded(
              child: isLoading 
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF4B3A)))
                : foods.isEmpty
                  ? const Center(child: Text('No food found for this category'))
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return _buildFoodCard(context, food);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, Food food) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: food),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: food.image.isNotEmpty 
                ? Image.network(
                    food.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),
                  )
                : const Icon(Icons.fastfood, size: 50),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                food.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${food.price}',
              style: const TextStyle(color: Color(0xFFFF4B3A), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
