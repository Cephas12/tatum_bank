import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _codeSent = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _sendResetCode() async {
    final email = _emailController.text.trim();
    if (!email.contains('@')) {
      _showMessage('Enter the email address linked to your account.');
      return;
    }

    final success = await context.read<AuthProvider>().startPasswordReset(
      email,
    );
    if (!mounted) return;
    if (success) {
      setState(() => _codeSent = true);
      _showMessage('A six-digit reset code has been sent to your email.');
    } else {
      _showMessage(
        context.read<AuthProvider>().errorMessage ??
            'Unable to send a reset code. Please try again.',
      );
    }
  }

  Future<void> _resetPassword() async {
    final otp = _otpController.text.trim();
    final password = _passwordController.text;
    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      _showMessage('Enter the six-digit code from your email.');
      return;
    }
    if (password != _confirmPasswordController.text) {
      _showMessage('Your passwords do not match.');
      return;
    }
    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}$',
    ).hasMatch(password)) {
      _showMessage(
        'Use 8+ characters with uppercase, lowercase, a number, and a symbol.',
      );
      return;
    }

    final success = await context.read<AuthProvider>().resetPassword(
      email: _emailController.text.trim(),
      otp: otp,
      newPassword: password,
    );
    if (!mounted) return;
    if (success) {
      _showMessage('Password reset successfully. You can now sign in.');
      Navigator.pop(context);
    } else {
      _showMessage(
        context.read<AuthProvider>().errorMessage ??
            'Unable to reset your password. Please try again.',
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.watch<AuthProvider>().passwordResetState == ViewState.loading;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF0B192C)),
        title: const Text(
          'Tatum Bank',
          style: TextStyle(
            color: Color(0xFF0B192C),
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _codeSent ? 'Enter your reset code' : 'Forgot Password?',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _codeSent
                    ? 'Enter the six-digit code sent to your email and choose a new password.'
                    : 'Enter the email address associated with your Tatum account. We will send you a one-time reset code.',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: _emailController,
                enabled: !_codeSent && !isLoading,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Email address',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_codeSent) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    labelText: 'Six-digit reset code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'New password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  decoration: const InputDecoration(
                    labelText: 'Confirm new password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : _codeSent
                      ? _resetPassword
                      : _sendResetCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC727),
                    foregroundColor: const Color(0xFF0B192C),
                  ),
                  child: Text(
                    isLoading
                        ? 'Please wait...'
                        : _codeSent
                        ? 'Reset Password'
                        : 'Send Reset Code',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (_codeSent)
                Center(
                  child: TextButton(
                    onPressed: isLoading ? null : _sendResetCode,
                    child: const Text('Resend code'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
