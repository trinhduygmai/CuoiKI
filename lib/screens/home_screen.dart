import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/header_menu_button.dart';
import '../widgets/food_card.dart';
import '../widgets/app_drawer.dart';
import '../types/types.dart';
import '../theme/app_theme.dart';
import '../context/global_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  Future<void> _initData() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    await provider.fetchCategories();
    if (provider.categories.isNotEmpty) {
      setState(() {
        selectedCategory = provider.categories[0];
      });
      await provider.fetchFoodsByCategory(selectedCategory!.id);
    }
  }

  Future<void> _onCategorySelected(Category category) async {
    setState(() {
      selectedCategory = category;
    });
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    await provider.fetchFoodsByCategory(category.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final categories = provider.categories;
    final foods = provider.foods;
    final isCategoriesLoading = provider.isDataLoading && categories.isEmpty;
    final isFoodsLoading = provider.isDataLoading &&
        foods
            .isNotEmpty; // This logic might need refinement based on how GlobalProvider handles loading

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderMenuButton(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
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
                    Stack(
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
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello ${provider.currentUser?.fullName.split(' ')[0] ?? 'User'},',
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
                ),
                const SizedBox(height: 32),
                // Categories section
                const Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textMain),
                ),
                const SizedBox(height: 16),
                isCategoriesLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppTheme.primary))
                    : categories.isEmpty
                        ? const Text('No categories available',
                            style: TextStyle(color: AppTheme.textSecondary))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categories
                                  .map((cat) => _buildCategoryItem(cat))
                                  .toList(),
                            ),
                          ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured items',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textMain),
                    ),
                    TextButton(
                      onPressed: () {
                        if (selectedCategory != null) {
                          Navigator.pushNamed(context, '/list',
                              arguments: selectedCategory);
                        }
                      },
                      child: const Text(
                        'SEE ALL',
                        style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                provider.isDataLoading && foods.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child:
                            CircularProgressIndicator(color: AppTheme.primary),
                      ))
                    : foods.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 40),
                                Icon(Icons.fastfood_outlined,
                                    size: 64, color: Colors.grey.shade300),
                                const SizedBox(height: 16),
                                const Text(
                                    'No food available for this category',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary)),
                              ],
                            ),
                          )
                        : Column(
                            children: foods
                                .map((food) => FoodCard(
                                      food: food,
                                      onTap: () => Navigator.pushNamed(
                                          context, '/detail',
                                          arguments: food),
                                    ))
                                .toList(),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Category category) {
    bool isSelected = selectedCategory?.id == category.id;
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: GestureDetector(
        onTap: () => _onCategorySelected(category),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : AppTheme.softShadow,
                border: Border.all(
                  color: isSelected ? AppTheme.primary : AppTheme.border,
                  width: isSelected ? 2 : 1,
                ),
                image: DecorationImage(
                  image: NetworkImage(category.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                color: isSelected ? AppTheme.primary : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
