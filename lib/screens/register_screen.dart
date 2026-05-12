import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/global_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  void _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu không khớp')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    
    final success = await Provider.of<GlobalProvider>(context, listen: false)
        .register(email, password);

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textMain),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(
                    Icons.fastfood_rounded,
                    size: 70,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join us and start exploring delicious food.',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 32),
                _buildInput('Email Address', _emailController, Icons.alternate_email_rounded, hint: 'john@example.com'),
                const SizedBox(height: 20),
                _buildInput('Password', _passwordController, Icons.lock_outline_rounded, isPassword: true, hint: '••••••••'),
                const SizedBox(height: 20),
                _buildInput('Confirm Password', _confirmPasswordController, Icons.lock_outline_rounded, isPassword: true, hint: '••••••••'),
                const SizedBox(height: 40),
                CustomButton(
                  label: 'SIGN UP',
                  isLoading: _isSubmitting,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: TextStyle(color: AppTheme.textSecondary)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, IconData icon, {bool isPassword = false, String? hint}) {
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
              hintText: hint ?? label,
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
