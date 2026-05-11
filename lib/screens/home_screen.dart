import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/header_menu_button.dart';
import '../widgets/food_card.dart';
import '../api/food_api.dart';
import '../types/types.dart';
import '../theme/app_theme.dart';
import '../context/global_provider.dart';

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
                    Column(
                      children: [
                        Text(
                          'DELIVER TO',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.shade400,
                            letterSpacing: 1,
                          ),
                        ),
                        const Text(
                          '123 Broadway St',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textMain,
                          ),
                        ),
                      ],
                    ),
                    Consumer<GlobalProvider>(
                      builder: (context, provider, _) => Stack(
                        children: [
                          HeaderMenuButton(
                            icon: Icons.shopping_cart_outlined,
                            onTap: () => Navigator.pushNamed(context, '/cart'),
                          ),
                          if (provider.cartItems.isNotEmpty)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '${provider.cartItems.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Consumer<GlobalProvider>(
                  builder: (context, provider, _) {
                    final userName = provider.currentUser?.fullName.split(' ')[0] ?? 'ds';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello $userName,',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Find your favorite meal!',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                // Categories section
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryItem('Italian', 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=100&h=100&fit=crop'),
                      _buildCategoryItem('Chinese', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=100&h=100&fit=crop'),
                      _buildCategoryItem('Japanese', 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=100&h=100&fit=crop'),
                      _buildCategoryItem('Vietnamese', 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=100&h=100&fit=crop'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured items',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textMain),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/list', arguments: selectedCategory),
                      child: const Text(
                        'SEE ALL',
                        style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w900, fontSize: 12),
                      ),
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

  Widget _buildCategoryItem(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: AppTheme.softShadow,
              border: Border.all(color: AppTheme.border),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
