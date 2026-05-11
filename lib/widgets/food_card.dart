import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../types/types.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          boxShadow: AppTheme.softShadow,
          border: Border.all(color: AppTheme.border, width: 1),
        ),
        child: Row(
          children: [
            Hero(
              tag: food.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                child: food.image.isNotEmpty
                    ? Image.network(
                        food.image,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppTheme.textMain,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.category,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${food.price}',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: AppTheme.primary, size: 14),
                            SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade100,
      child: const Icon(Icons.fastfood, color: Colors.grey),
    );
  }
}
