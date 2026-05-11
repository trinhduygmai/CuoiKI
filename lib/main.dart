import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'context/global_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/food_list_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/payment_success_screen.dart';
import 'types/types.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()..checkAuth()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const AuthWrapper());
        }
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }
        if (settings.name == '/register') {
          return MaterialPageRoute(builder: (context) => const RegisterScreen());
        }
        if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
        if (settings.name == '/cart') {
          return MaterialPageRoute(builder: (context) => const CartScreen());
        }
        if (settings.name == '/profile') {
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        }
        if (settings.name == '/checkout') {
          return MaterialPageRoute(builder: (context) => const CheckoutScreen());
        }
        if (settings.name == '/success') {
          return MaterialPageRoute(builder: (context) => const PaymentSuccessScreen());
        }
        if (settings.name == '/list') {
          final category = settings.arguments as Category;
          return MaterialPageRoute(builder: (context) => FoodListScreen(category: category));
        }
        if (settings.name == '/detail') {
          final food = settings.arguments as Food;
          return MaterialPageRoute(builder: (context) => FoodDetailScreen(food: food));
        }
        return null;
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<GlobalProvider>(context);
    
    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFFF4B3A)),
        ),
      );
    }
    
    return authProvider.isAuthenticated ? const HomeScreen() : const LoginScreen();
  }
}
