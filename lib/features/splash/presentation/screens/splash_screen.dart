import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/services/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  late AnimationController _particleController;

  late Animation<double> _backgroundAnimation;
  late Animation<double> _contentAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Background gradient animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));

    // Content fade and scale animation
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _contentAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: Curves.elasticOut,
    ));

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _particleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));
  }

  void _startSplashSequence() async {
    // Start background animation
    _backgroundController.forward();

    // Wait a bit then start content animation
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _contentController.forward();

    // Start particle animation
    _particleController.repeat();

    // Wait for splash duration then navigate
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    NavigationService.navigateFromSplash();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AnimatedBuilder(
          animation: Listenable.merge([
            _backgroundAnimation,
            _contentAnimation,
            _particleAnimation,
          ]),
          builder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.8),
                  AppTheme.secondaryColor,
                  AppTheme.accentColor.withOpacity(0.6),
                ],
                stops: [
                  0.0,
                  0.3 * _backgroundAnimation.value,
                  0.7 * _backgroundAnimation.value,
                  1.0,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated particles background
                ..._buildParticles(),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animation
                      Transform.scale(
                        scale: _contentAnimation.value.clamp(0.0, 1.0),
                        child: Opacity(
                          opacity: _contentAnimation.value.clamp(0.0, 1.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: const AppLogo(
                              size: 120,
                              showText: true,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Loading indicator with custom styling
                      Transform.scale(
                        scale: _contentAnimation.value.clamp(0.0, 1.0),
                        child: Opacity(
                          opacity: _contentAnimation.value.clamp(0.0, 1.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Loading text
                      Transform.translate(
                        offset: Offset(0,
                            20 * (1 - _contentAnimation.value.clamp(0.0, 1.0))),
                        child: Opacity(
                          opacity: _contentAnimation.value.clamp(0.0, 1.0),
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom wave decoration
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(
                        0, 50 * (1 - _contentAnimation.value.clamp(0.0, 1.0))),
                    child: Opacity(
                      opacity: _contentAnimation.value.clamp(0.0, 1.0),
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 100),
                        painter: WavePainter(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> _buildParticles() {
    List<Widget> particles = [];

    for (int i = 0; i < 20; i++) {
      double x = (i * 37.0) % MediaQuery.of(context).size.width;
      double y = (i * 23.0) % MediaQuery.of(context).size.height;

      particles.add(
        Positioned(
          left: x,
          top: y,
          child: Transform.translate(
            offset: Offset(
              30 * (0.5 - (_particleAnimation.value * 2 - 1).abs()),
              20 * (0.5 - (_particleAnimation.value * 2 - 1).abs()),
            ),
            child: Opacity(
              opacity: (0.3 * (1 - (_particleAnimation.value * 2 - 1).abs()))
                  .clamp(0.0, 1.0),
              child: Container(
                width: 4 + (i % 3) * 2,
                height: 4 + (i % 3) * 2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return particles;
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height * 0.5 + 20 * sin(1 + (x / size.width) * 2 * pi);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
