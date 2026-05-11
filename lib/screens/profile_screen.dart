import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<GlobalProvider>(context);
    final user = authProvider.currentUser;

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
                    const Text(
                      'Profile',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textMain),
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'My Profile',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textMain),
                ),
                const SizedBox(height: 24),
                // Profile Card
                _buildCard(
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                          border: Border.all(color: AppTheme.border),
                        ),
                        child: const Icon(Icons.person, size: 40, color: AppTheme.textMuted),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.fullName ?? 'Hồ Bá Nghĩa',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.textMain),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'nghia@example.com',
                              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Change', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildMenuItem('Orders', Icons.shopping_bag_outlined),
                _buildMenuItem('Pending reviews', Icons.rate_review_outlined),
                _buildMenuItem('Faq', Icons.help_outline_rounded),
                _buildMenuItem('Help', Icons.support_agent_rounded),
                const SizedBox(height: 60),
                CustomButton(
                  label: 'Logout',
                  color: Colors.redAccent,
                  onPressed: () async {
                    await authProvider.logout();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.softShadow,
        border: Border.all(color: AppTheme.border),
      ),
      child: child,
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: AppTheme.softShadow,
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppTheme.textMain),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: AppTheme.textMuted),
        ],
      ),
    );
  }
}
