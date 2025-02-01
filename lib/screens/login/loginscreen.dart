import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return CustomPaint(
                painter: BackgroundPainter(_controller.value),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  // Animated Logo
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: const Text(
                            'MedXcure',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  // Animated Tagline
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: const Text(
                            'Your Health, Our Priority',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),

                  // Animated Buttons
                  Column(
                    children: [
                      _buildAnimatedButton('LOGIN', () {
                        Navigator.pushNamed(context, '/welcomeback');
                      }, isPrimary: true),

                      const SizedBox(height: 16),

                      _buildAnimatedButton('SIGN UP', () {
                        Navigator.pushNamed(context, '/create-account');
                      }, isPrimary: false),
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Animated Button Builder
  Widget _buildAnimatedButton(String text, VoidCallback onPressed, {required bool isPrimary}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPrimary ? const Color(0xFF70FACC) : Colors.transparent,
                  foregroundColor: Colors.white,
                  side: isPrimary ? null : const BorderSide(color: Color(0xFF70FACC), width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: onPressed,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom painter for animated background
class BackgroundPainter extends CustomPainter {
  final double value;

  BackgroundPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF70FACC).withOpacity(0.1),
          const Color(0xFF1A1B2E).withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    for (var i = 0; i < 5; i++) {
      final xOffset = size.width * 0.1 * math.sin(value * math.pi * 2 + i);
      final yOffset = size.height * 0.1 * math.cos(value * math.pi * 2 + i);
      path.addOval(
        Rect.fromCenter(
          center: Offset(
            size.width * (0.2 + (i * 0.2)) + xOffset,
            size.height * (0.2 + (i * 0.2)) + yOffset,
          ),
          width: size.width * 0.3,
          height: size.height * 0.3,
        ),
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;
}
