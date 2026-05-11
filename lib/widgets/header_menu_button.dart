import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeaderMenuButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const HeaderMenuButton({
    super.key, 
    this.onTap,
    this.icon = Icons.notes_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Scaffold.of(context).openDrawer(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: AppTheme.softShadow,
          border: Border.all(color: AppTheme.border),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color: AppTheme.secondary,
          ),
        ),
      ),
    );
  }
}
