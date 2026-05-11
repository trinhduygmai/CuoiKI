import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    
    final success = await Provider.of<GlobalProvider>(context, listen: false)
        .login(_emailController.text, _passwordController.text);

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.fastfood_rounded,
                  size: 80,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Sign in to access your favorite food and previous orders.',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 48),
              _buildInput('Email Address', _emailController, Icons.alternate_email_rounded),
              const SizedBox(height: 24),
              _buildInput('Password', _passwordController, Icons.lock_outline_rounded, isPassword: true),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                label: 'SIGN IN',
                isLoading: _isSubmitting,
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? ', style: TextStyle(color: AppTheme.textSecondary)),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: const TextStyle(
            fontWeight: FontWeight.w700, 
            fontSize: 14, 
            color: AppTheme.textMain,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(color: AppTheme.border),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppTheme.textMuted, size: 22),
              hintText: isPassword ? '••••••••' : 'Enter your email',
              hintStyle: const TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }
}
