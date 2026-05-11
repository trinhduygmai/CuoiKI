import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final user = provider.currentUser;
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // User Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: const Icon(Icons.person, size: 30, color: AppTheme.textMuted),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.fullName ?? 'Hồ Bá Nghĩa', // Default name from prompt images/context if available or fallback
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AppTheme.textMain,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'user@example.com',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              // Menu Items
              _buildMenuItem(
                context,
                icon: Icons.home_rounded,
                title: 'Home',
                route: '/home',
                isActive: currentRoute == '/home' || currentRoute == '/',
              ),
              _buildMenuItem(
                context,
                icon: Icons.shopping_cart_rounded,
                title: 'My Cart',
                route: '/cart',
                isActive: currentRoute == '/cart',
              ),
              _buildMenuItem(
                context,
                icon: Icons.person_rounded,
                title: 'Profile',
                route: '/profile',
                isActive: currentRoute == '/profile',
              ),
              const Spacer(),
              _buildMenuItem(
                context,
                icon: Icons.logout_rounded,
                title: 'Logout',
                route: '/login',
                isLogout: true,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    bool isActive = false,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.redAccent : (isActive ? AppTheme.primary : AppTheme.textMain);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: () async {
          if (isLogout) {
            await Provider.of<GlobalProvider>(context, listen: false).logout();
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          } else {
            Navigator.pop(context); // Close drawer
            if (ModalRoute.of(context)?.settings.name != route) {
               Navigator.pushNamed(context, route);
            }
          }
        },
        leading: Icon(icon, color: color, size: 24),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: isActive ? AppTheme.primary.withOpacity(0.08) : Colors.transparent,
      ),
    );
  }
}
