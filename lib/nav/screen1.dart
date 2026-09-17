import 'dart:async';

import 'package:flutter/material.dart';
import '../app/app_colors.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Screen2()),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bottom Yellow Graphic
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: const SplashWaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.32,
                color: AppColors.primary,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                // Logo
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPetal(
                                  AppColors.primary,
                                  const BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                _buildPetal(
                                  AppColors.navy,
                                  const BorderRadius.only(
                                    topRight: Radius.circular(7),
                                    bottomLeft: Radius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPetal(
                                  AppColors.primary,
                                  const BorderRadius.only(
                                    bottomLeft: Radius.circular(7),
                                    topRight: Radius.circular(7),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                _buildPetal(
                                  AppColors.primary,
                                  const BorderRadius.only(
                                    bottomRight: Radius.circular(7),
                                    topLeft: Radius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tatum',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navy,
                              letterSpacing: -1,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -8),
                            child: const Text(
                              'Bank',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.navy,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                // Text Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Banking that\nkeeps you smiling',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'All-in-One Banking, All for You',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.navy.withAlpha(204), // 80% opacity
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetal(Color color, BorderRadius radius) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(color: color, borderRadius: radius),
    );
  }
}

class SplashWaveClipper extends CustomClipper<Path> {
  const SplashWaveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    // The reference rises gently from the lower-left edge and crests near
    // the upper-right edge rather than forming a centered wave.
    path.moveTo(0, size.height * 0.56);
    path.cubicTo(
      size.width * 0.28,
      size.height * 0.65,
      size.width * 0.62,
      size.height * 0.04,
      size.width,
      size.height * 0.12,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
