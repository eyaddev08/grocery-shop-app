import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import '../utils/styles.dart';

class LoadingWidget extends StatelessWidget {

  const LoadingWidget({
    super.key,
    this.message,
    this.size,
    this.color,
  });
  final String? message;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size ?? 50,
            height: size ?? 50,
            child: CircularProgressIndicator(
              color: color ?? kPrimaryBlue,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: textBold,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
}

class LoadingOverlay extends StatelessWidget {

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.loadingMessage,
    this.overlayColor,
  });
  final Widget child;
  final bool isLoading;
  final String? loadingMessage;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) => Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
            color: overlayColor ?? Colors.black.withOpacity(0.5),
            child: LoadingWidget(
              message: loadingMessage,
              color: Colors.white,
            ),
          ),
      ],
    );
}

class ShimmerLoading extends StatefulWidget {

  const ShimmerLoading({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final Widget child;
  final bool isLoading;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds),
          child: widget.child,
        ),
    );
  }
}

class LoadingButton extends StatelessWidget {

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
    this.icon,
    this.style,
  });
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Widget? icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(text),
              ],
            ),
    );
}

class LoadingCard extends StatelessWidget {

  const LoadingCard({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
  });
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Card(
      margin: margin,
      child: Container(
        height: height ?? 200,
        width: width,
        padding: padding ?? const EdgeInsets.all(16),
        child: const LoadingWidget(),
      ),
    );
}

class LoadingList extends StatelessWidget {

  const LoadingList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.padding,
  });
  final int itemCount;
  final double itemHeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) => Container(
          height: itemHeight,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
    );
}

class LoadingGrid extends StatelessWidget {

  const LoadingGrid({
    super.key,
    this.itemCount = 6,
    this.itemHeight = 200,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.padding,
  });
  final int itemCount;
  final double itemHeight;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => Container(
          height: itemHeight,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
    );
}
