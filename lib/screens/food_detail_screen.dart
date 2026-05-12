import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../types/types.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class FoodDetailScreen extends StatefulWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;
  Food? foodDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFoodDetail();
  }

  Future<void> _loadFoodDetail() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    final detail = await provider.fetchFoodDetail(widget.food.id);
    if (mounted) {
      setState(() {
        foodDetail = detail ?? widget.food;
        isLoading = false;
      });
    }
  }

  Future<void> _handleAddToCart() async {
    final provider = Provider.of<GlobalProvider>(context, listen: false);
    final success = await provider.addToCart(foodDetail ?? widget.food, quantity: quantity);
    
    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added $quantity ${(foodDetail ?? widget.food).name} to cart'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppTheme.secondary,
            action: SnackBarAction(
              label: 'VIEW CART',
              textColor: AppTheme.primary,
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add to cart. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final food = foodDetail ?? widget.food;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Hero(
                    tag: food.id,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: food.image.isNotEmpty 
                          ? Image.network(
                              food.image, 
                              fit: BoxFit.cover, 
                              errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, size: 100),
                            )
                          : const Icon(Icons.fastfood, size: 100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                isLoading 
                  ? const Center(child: CircularProgressIndicator(color: AppTheme.primary))
                  : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              food.name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.favorite_rounded, color: AppTheme.primary, size: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '\$${food.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBadge(Icons.star_rounded, '4.8', 'Rating'),
                          _buildBadge(Icons.local_fire_department_rounded, '120', 'Kcal'),
                          _buildBadge(Icons.timer_rounded, '20 min', 'Delivery'),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.textMain),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        food.description,
                        style: const TextStyle(color: AppTheme.textSecondary, height: 1.7, fontSize: 15),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quantity',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.textMain),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              borderRadius: BorderRadius.circular(AppTheme.radiusM),
                              border: Border.all(color: AppTheme.border),
                            ),
                            child: Row(
                              children: [
                                _buildQtyButton(Icons.remove, () {
                                  if (quantity > 1) setState(() => quantity--);
                                }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _buildQtyButton(Icons.add, () {
                                  setState(() => quantity++);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 24,
            child: GestureDetector(
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
          ),
          if (!isLoading)
          Positioned(
            bottom: 40,
            left: 32,
            right: 32,
            child: CustomButton(
              label: 'Add to Cart',
              onPressed: _handleAddToCart,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.border),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 20),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
          boxShadow: AppTheme.softShadow,
        ),
        child: Icon(icon, size: 18, color: AppTheme.textMain),
      ),
    );
  }
}
