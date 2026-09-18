import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import '../providers/auth_provider.dart';
import '../providers/account_provider.dart';
import 'screen3.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('remembered_email');
    if (savedEmail != null && mounted) {
      setState(() {
        _emailController.text = savedEmail;
      });
    }
  }

  Future<void> _submit() async {
    final auth = context.read<AuthProvider>();
    final email = _emailController.text.trim();
    
    final success = await auth.login(
      email,
      _passwordController.text,
    );
    
    if (!success) return;

    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
        await prefs.setString('remembered_email', email);
    } else {
        await prefs.remove('remembered_email');
    }
    if (!mounted) return;

    // Refresh account data with the new token
    await context.read<AccountProvider>().refresh(auth.user.token);

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  Future<void> _handleBiometricLogin() async {
    final auth = context.read<AuthProvider>();
    final localAuth = LocalAuthentication();
    
    try {
      final canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometrics not available on this device.')),
          );
        }
        return;
      }

      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to log in to Tatum Bank',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate && mounted) {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (!mounted) return;

        if (token != null) {
          await auth.bootstrap();
          if (!mounted || !auth.isLoggedIn) return;
          
          // Refresh account data
          await context.read<AccountProvider>().refresh(auth.user.token);

          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please log in with password once to enable biometrics.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final isLoading = auth.loginState == ViewState.loading;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // 1. Programmatically Drawn Logo
              const Center(
                child: TatumLogoWidget(),
              ),

              const SizedBox(height: 36),

              // 2. Header Text
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Log in to your Tatum account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A94A6),
                ),
              ),

              const SizedBox(height: 28),

              // 3. Email Input
              const Text(
                'Email or Phone Number',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                style: const TextStyle(fontSize: 14, color: Color(0xFF0B192C)),
                decoration: InputDecoration(
                  hintText: 'john.doe@email.com',
                  errorText: auth.fieldError('email'),
                  hintStyle: const TextStyle(color: Color(0xFFB0B7C3), fontSize: 14),
                  prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF9EA8B6), size: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFC727), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 4. Password Input
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B192C),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(fontSize: 14, color: Color(0xFF0B192C)),
                decoration: InputDecoration(
                  hintText: '••••••••••••',
                  errorText: auth.fieldError('password'),
                  hintStyle: const TextStyle(color: Color(0xFFB0B7C3), fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF9EA8B6), size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xFF9EA8B6),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFC727), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 5. Options (Remember me / Forgot password)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: const Color(0xFF0B192C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0B192C),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B192C),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              if (auth.loginState == ViewState.error && auth.errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          auth.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),

              // 6. Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC727),
                    foregroundColor: const Color(0xFF0B192C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF0B192C),
                          ),
                        )
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // 7. Divider
              Row(
                children: const [
                  Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB0B7C3),
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                ],
              ),

              const SizedBox(height: 24),

              // 8. Biometric Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _handleBiometricLogin,
                  icon: const Icon(
                    Icons.fingerprint_rounded,
                    color: Color(0xFF0B192C),
                    size: 22,
                  ),
                  label: const Text(
                    'Log in with Biometrics',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B192C),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 9. Footer
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Screen3()),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B192C),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}


// Custom Rendered Tatum Logo Component
class TatumLogoWidget extends StatelessWidget {
  const TatumLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 44,
          height: 44,
          child: CustomPaint(
            painter: _TatumIconPainter(),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Tatum',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0B192C),
                height: 1.0,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 1),
            Text(
              'Bank',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0B192C),
                height: 1.0,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TatumIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double gap = size.width * 0.08;
    final double tileSize = (size.width - gap) / 2;

    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFFC727)
      ..style = PaintingStyle.fill;

    final Paint darkPaint = Paint()
      ..color = const Color(0xFF0B192C)
      ..style = PaintingStyle.fill;

    final double cornerRadius = tileSize * 0.45;

    // Top-Left (Yellow)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, tileSize, tileSize),
        topLeft: Radius.circular(cornerRadius),
        topRight: const Radius.circular(3),
        bottomLeft: const Radius.circular(3),
        bottomRight: const Radius.circular(3),
      ),
      yellowPaint,
    );

    // Top-Right (Dark Navy)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(tileSize + gap, 0, tileSize, tileSize),
        topRight: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(3),
        bottomLeft: const Radius.circular(3),
        bottomRight: const Radius.circular(3),
      ),
      darkPaint,
    );

    // Bottom-Left (Yellow)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, tileSize + gap, tileSize, tileSize),
        bottomLeft: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
        bottomRight: const Radius.circular(3),
      ),
      yellowPaint,
    );

    // Bottom-Right (Yellow)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(tileSize + gap, tileSize + gap, tileSize, tileSize),
        bottomRight: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(3),
        topRight: const Radius.circular(3),
        bottomLeft: const Radius.circular(3),
      ),
      yellowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}