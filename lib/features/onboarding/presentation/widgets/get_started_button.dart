import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
    required this.onPressed,
    required this.background,
    required this.text,
  });
  final VoidCallback onPressed;
  final Color background;
  final Color text;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Get Started', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 22),
          ],
        ),
      ),
    );
}