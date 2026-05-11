import 'package:flutter/material.dart';
import '../widgets/header_menu_button.dart';
import '../widgets/food_card.dart';
import '../api/food_api.dart';
import '../types/types.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> foods = [];
  bool isLoading = true;
  String selectedCategory = 'Pizza';

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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderMenuButton(),
                    HeaderMenuButton(
                      icon: Icons.person_outline,
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Delicious\nfood for you',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 32),
                // Custom Search
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    boxShadow: AppTheme.softShadow,
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: AppTheme.textSecondary),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search delicious food',
                            hintStyle: TextStyle(color: AppTheme.textMuted),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Pizza', 'Fast Food', 'Chicken', 'Snacks', 'Sauce'].map((cat) {
                      bool isSelected = selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedCategory = cat),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cat,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                  fontSize: 16,
                                  color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 3,
                                width: isSelected ? 24 : 0,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Foods',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/list', arguments: selectedCategory),
                      child: const Text('See all', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                isLoading 
                  ? const Center(child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(color: AppTheme.primary),
                    ))
                  : foods.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Icon(Icons.fastfood_outlined, size: 64, color: Colors.grey.shade300),
                            const SizedBox(height: 16),
                            const Text('No food available right now', style: TextStyle(color: AppTheme.textSecondary)),
                          ],
                        ),
                      )
                    : Column(
                        children: foods.map((food) => FoodCard(
                          food: food,
                          onTap: () => Navigator.pushNamed(context, '/detail', arguments: food),
                        )).toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
