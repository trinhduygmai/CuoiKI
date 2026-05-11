import 'package:flutter/material.dart';

class HeaderMenuButton extends StatelessWidget {
  final VoidCallback? onTap;

  const HeaderMenuButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Scaffold.of(context).openDrawer(),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade50),
        ),
        child: const Center(
          child: Icon(
            Icons.menu_rounded,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
