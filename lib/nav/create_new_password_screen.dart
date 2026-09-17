import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Validation States
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final text = _passwordController.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasUppercase = text.contains(RegExp(r'[A-Z]'));
      _hasNumber = text.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = text.contains(RegExp(r'[^a-zA-Z0-9]'));
    });
  }

  int get _strengthScore {
    int score = 0;
    if (_hasMinLength) score++;
    if (_hasUppercase) score++;
    if (_hasNumber) score++;
    if (_hasSpecialChar) score++;
    return score;
  }

  String get _strengthText {
    switch (_strengthScore) {
      case 1:
        return 'Weak';
      case 2:
      case 3:
        return 'Medium';
      case 4:
        return 'Strong';
      default:
        return '';
    }
  }

  Color get _strengthColor {
    switch (_strengthScore) {
      case 1:
        return const Color(0xFFE53E3E);
      case 2:
      case 3:
        return const Color(0xFFDD6B20);
      case 4:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFFE2E8F0);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Arrow and Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0B192C)),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                  const TatumLogoWidget(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Header Text
                    const Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B192C),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Enter your new password below.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A94A6),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // New Password Field
                    const Text(
                      'New Password',
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

                    const SizedBox(height: 16),

                    // Password Strength Header & Bars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Password Strength',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8A94A6),
                          ),
                        ),
                        Text(
                          _strengthText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _strengthColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 4-Segment Strength Indicator
                    Row(
                      children: List.generate(4, (index) {
                        final bool isActive = index < _strengthScore;
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(right: index == 3 ? 0 : 6),
                            decoration: BoxDecoration(
                              color: isActive ? _strengthColor : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // Requirement Checklist
                    _RequirementItem(text: 'At least 8 characters', isMet: _hasMinLength),
                    const SizedBox(height: 8),
                    _RequirementItem(text: 'One uppercase letter', isMet: _hasUppercase),
                    const SizedBox(height: 8),
                    _RequirementItem(text: 'One number', isMet: _hasNumber),
                    const SizedBox(height: 8),
                    _RequirementItem(text: 'One special character', isMet: _hasSpecialChar),

                    const SizedBox(height: 24),

                    // Confirm New Password Field
                    const Text(
                      'Confirm New Password',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B192C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF0B192C)),
                      decoration: InputDecoration(
                        hintText: '••••••••••••',
                        hintStyle: const TextStyle(color: Color(0xFFB0B7C3), fontSize: 14),
                        prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF9EA8B6), size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF9EA8B6),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
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

                    const SizedBox(height: 32),

                    // Reset Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Trigger password reset logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC727),
                          foregroundColor: const Color(0xFF0B192C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Back to Login Link
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B192C),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Requirement Item Widget
class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _RequirementItem({
    required this.text,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 18,
          color: isMet ? const Color(0xFF10B981) : const Color(0xFFCBD5E1),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isMet ? const Color(0xFF0B192C) : const Color(0xFF8A94A6),
          ),
        ),
      ],
    );
  }
}

// Reusable Tatum Logo Component
class TatumLogoWidget extends StatelessWidget {
  const TatumLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: CustomPaint(
            painter: _TatumIconPainter(),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Tatum',
              style: TextStyle(
                fontSize: 18,
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
                fontSize: 10,
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
        topRight: const Radius.circular(2),
        bottomLeft: const Radius.circular(2),
        bottomRight: const Radius.circular(2),
      ),
      yellowPaint,
    );

    // Top-Right (Dark Navy)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(tileSize + gap, 0, tileSize, tileSize),
        topRight: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(2),
        bottomLeft: const Radius.circular(2),
        bottomRight: const Radius.circular(2),
      ),
      darkPaint,
    );

    // Bottom-Left (Yellow)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, tileSize + gap, tileSize, tileSize),
        bottomLeft: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(2),
        topRight: const Radius.circular(2),
        bottomRight: const Radius.circular(2),
      ),
      yellowPaint,
    );

    // Bottom-Right (Yellow)
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(tileSize + gap, tileSize + gap, tileSize, tileSize),
        bottomRight: Radius.circular(cornerRadius),
        topLeft: const Radius.circular(2),
        topRight: const Radius.circular(2),
        bottomLeft: const Radius.circular(2),
      ),
      yellowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}