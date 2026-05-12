import 'package:flutter/material.dart';
import '../api/food_api.dart';
import '../types/types.dart';
import '../theme/app_theme.dart';
import '../widgets/food_card.dart';

class FoodListScreen extends StatefulWidget {
  final CategoryModel category;

  const FoodListScreen({super.key, required this.category});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<FoodModel> foods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    final fetchedFoods = await FoodApi.getFoodsByCategory(widget.category.id);
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.softShadow,
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.category.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textMain),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppTheme.primary))
                : foods.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade200),
                          const SizedBox(height: 16),
                          const Text('No food found for this category', style: TextStyle(color: AppTheme.textSecondary)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return FoodCard(
                          food: food, 
                          onTap: () => Navigator.pushNamed(context, '/detail', arguments: food),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
