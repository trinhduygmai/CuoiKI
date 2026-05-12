import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<GlobalProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Cart',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textMain),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_basket_outlined, size: 100, color: Colors.grey.shade200),
                          const SizedBox(height: 16),
                          const Text(
                            'Your cart is empty',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            label: 'Explore Foods',
                            width: 200,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return _buildCartItem(context, item, cartProvider);
                      },
                    ),
            ),
            if (cartItems.isNotEmpty) _buildSummary(context, cartProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, GlobalProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.softShadow,
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            child: item.food.image.isNotEmpty
                ? Image.network(item.food.image, width: 80, height: 80, fit: BoxFit.cover)
                : Container(width: 80, height: 80, color: AppTheme.background, child: const Icon(Icons.fastfood)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.food.name,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textMain),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.food.price}',
                  style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildMiniQtyButton(Icons.remove, () => provider.updateQuantityLocal(item.food.id, item.quantity - 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _buildMiniQtyButton(Icons.add, () => provider.updateQuantityLocal(item.food.id, item.quantity + 1)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => provider.removeFromCartLocal(item.food.id),
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniQtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildSummary(BuildContext context, GlobalProvider provider) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXXL)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', '\$${provider.totalAmount.toStringAsFixed(2)}', isBold: false),
          const SizedBox(height: 12),
          _buildSummaryRow('Delivery', '\$5.00', isBold: false),
          const SizedBox(height: 12),
          const Divider(color: AppTheme.border),
          const SizedBox(height: 12),
          _buildSummaryRow('Total', '\$${(provider.totalAmount + 5).toStringAsFixed(2)}', isBold: true),
          const SizedBox(height: 32),
          CustomButton(
            label: 'CHECKOUT',
            onPressed: () => Navigator.pushNamed(context, '/checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool isBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? AppTheme.textMain : AppTheme.textSecondary,
            fontSize: isBold ? 18 : 15,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isBold ? AppTheme.primary : AppTheme.textMain,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
