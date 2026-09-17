import 'package:flutter/material.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar with Back Button & Logo
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Success Icon with Dual Outer Halo Rings
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EA),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            spreadRadius: 12,
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Title
                    const Text(
                      'Password Reset\nSuccessful',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B192C),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    const Text(
                      'Your password has been updated\nsuccessfully. You can now log in with\nyour new credentials.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF8A94A6),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Back to Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate back to Login and clear route stack
                          Navigator.of(context).popUntil((route) => route.isFirst);
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
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),
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