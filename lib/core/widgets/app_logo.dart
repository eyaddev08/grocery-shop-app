import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;
  final String? customText;

  const AppLogo({
    super.key,
    this.size = 120.0,
    this.showText = true,
    this.color,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? AppTheme.primaryColor;
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? AppTheme.darkTextPrimaryColor
        : AppTheme.textPrimaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Container with gradient background
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                logoColor,
                logoColor.withOpacity(0.9),
                AppTheme.secondaryColor,
                AppTheme.accentColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(size * 0.25),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: logoColor.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Shopping cart icon
              Center(
                child: Container(
                  width: size * 0.65,
                  height: size * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(size * 0.15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    size: size * 0.4,
                    color: Colors.white,
                  ),
                ),
              ),
              // Fresh produce indicator (small green dot)
              Positioned(
                top: size * 0.12,
                right: size * 0.12,
                child: Container(
                  width: size * 0.18,
                  height: size * 0.18,
                  decoration: BoxDecoration(
                    color: AppTheme.successColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.successColor.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: size * 0.08,
                    color: Colors.white,
                  ),
                ),
              ),
              // Organic leaf indicator
              Positioned(
                top: size * 0.08,
                left: size * 0.08,
                child: Container(
                  padding: EdgeInsets.all(size * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.eco_rounded,
                    size: size * 0.14,
                    color: AppTheme.successColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (showText) ...[
          const SizedBox(height: 20),
          // App name with custom styling
          Text(
            customText ?? 'Grocery Shop',
            style: TextStyle(
              fontSize: size * 0.22,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Tagline
          Text(
            'Fresh & Organic',
            style: TextStyle(
              fontSize: size * 0.11,
              fontWeight: FontWeight.w500,
              color: textColor.withOpacity(0.8),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ],
    );
  }
}

class AnimatedAppLogo extends StatefulWidget {
  final double size;
  final bool showText;
  final Color? color;
  final String? customText;
  final Duration animationDuration;

  const AnimatedAppLogo({
    super.key,
    this.size = 120.0,
    this.showText = true,
    this.color,
    this.customText,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedAppLogo> createState() => _AnimatedAppLogoState();
}

class _AnimatedAppLogoState extends State<AnimatedAppLogo>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _rotationController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    await _scaleController.forward();
    await _fadeController.forward();
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _fadeAnimation,
        _rotationAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: AppLogo(
                size: widget.size,
                showText: widget.showText,
                color: widget.color,
                customText: widget.customText,
              ),
            ),
          ),
        );
      },
    );
  }
}
