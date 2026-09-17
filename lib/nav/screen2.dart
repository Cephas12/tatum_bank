import 'package:flutter/material.dart';
import '../app/app_colors.dart';
import '../app/app_spacing.dart';
import 'screen3.dart';
import 'login_screen.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Solid yellow lower panel. Keep this as one layer so the
          // image does not show through a conflicting translucent wave.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: screenHeight * 0.45,
            child: ClipPath(
              clipper: const WaveClipperBottom(),
              child: const ColoredBox(color: AppColors.primary),
            ),
          ),

          // 2. Foreground Layout
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Headline Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'All-in-One Banking,',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0A192F),
                          height: 1.15,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'All for You',
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0A192F),
                          height: 1.15,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Open a Tatum Account in minutes and enjoy seamless banking.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Image
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(
                        'assets/images/onboarding_man.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Bottom Actions
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxxl,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Screen3(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A192F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0A192F),
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: 'I already have an account? '),
                              TextSpan(
                                text: 'Log in',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A192F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipperBottom extends CustomClipper<Path> {
  const WaveClipperBottom();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.20);
    path.cubicTo(
      size.width * 0.28,
      size.height * 0.25,
      size.width * 0.67,
      size.height * 0.08,
      size.width,
      size.height * 0.18,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
