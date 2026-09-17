import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../app/app_spacing.dart';
import 'otp_screen.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) return;

      final auth = context.read<AuthProvider>();
      final success = await auth.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.replaceAll(RegExp(r'\s+'), ''),
        password: _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              email: _emailController.text.trim(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final isLoading = auth.registerState == ViewState.loading;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(child: _TatumLogo()),
                const SizedBox(height: 36),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0A192F),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join Tatum Bank today',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF0A192F).withAlpha(150),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 28),
                _buildInputField(
                  label: 'First Name',
                  hint: 'Jane',
                  icon: Icons.person_outline,
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  errorText: auth.fieldError('name'),
                  validator: (val) =>
                  val == null || val.isEmpty ? 'Please enter your first name' : null,
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  label: 'Last Name',
                  hint: 'Doe',
                  icon: Icons.person_outline,
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (val) =>
                  val == null || val.isEmpty ? 'Please enter your last name' : null,
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  label: 'Email Address',
                  hint: 'jane.doe@email.com',
                  icon: Icons.mail_outline,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: auth.fieldError('email'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  label: 'Phone Number',
                  hint: '+1234 567 890',
                  icon: Icons.smartphone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  errorText: auth.fieldError('phone'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^(?:\+234|0)[789][01]\d{8}$')
                        .hasMatch(val.replaceAll(RegExp(r'\s+'), ''))) {
                      return 'Enter a valid Nigerian phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  label: 'Password',
                  hint: '••••••••••••',
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  errorText: auth.fieldError('password'),
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter a password';
                    if (!RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,100}$',
                    ).hasMatch(val)) {
                      return 'Use 8+ characters with uppercase, lowercase, a number, and a symbol';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        activeColor: const Color(0xFF0A192F),
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _agreeToTerms = !_agreeToTerms;
                          });
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0A192F),
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (auth.registerState == ViewState.error &&
                    auth.errorMessage != null &&
                    auth.fieldErrors.isEmpty)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      auth.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_agreeToTerms && !isLoading) ? _handleSignUp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _agreeToTerms ? const Color(0xFFFFCC00) : const Color(0xFFF6F5F3),
                      foregroundColor: _agreeToTerms ? const Color(0xFF0A192F) : const Color(0xFF0A192F).withAlpha(100),
                      disabledBackgroundColor: const Color(0xFFF6F5F3),
                      disabledForegroundColor: const Color(0xFF0A192F).withAlpha(100),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF0A192F),
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0A192F),
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    String? Function(String?)? validator,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0A192F),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
            ),
            prefixIcon: Icon(icon, color: Colors.grey.shade500, size: 20),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey.shade500,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0A192F), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}

class _TatumLogo extends StatelessWidget {
  const _TatumLogo();

  Widget _buildPetal(Color color, BorderRadius radius, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPetal(const Color(0xFFFFCC00), const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)), 18),
                  const SizedBox(width: 2),
                  _buildPetal(const Color(0xFF0A192F), const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12)), 18),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPetal(const Color(0xFFFFCC00), const BorderRadius.only(bottomLeft: Radius.circular(12), topRight: Radius.circular(12)), 18),
                  const SizedBox(width: 2),
                  _buildPetal(const Color(0xFFFFCC00), const BorderRadius.only(bottomRight: Radius.circular(12), topLeft: Radius.circular(12)), 18),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tatum',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A192F),
                letterSpacing: -0.5,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -6),
              child: const Text(
                'Bank',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A192F),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}