import 'package:flutter/material.dart';

class PopularTags extends StatelessWidget {
  final List<String> tags;
  final ValueChanged<String> onTagTap;

  const PopularTags({
    super.key,
    required this.tags,
    required this.onTagTap,
  });

  @override
  Widget build(BuildContext context) => Wrap(
      spacing: 8,
      runSpacing: 12,
      children: tags.map((t) => _buildTagChip(context, t)).toList(),
    );

  Widget _buildTagChip(BuildContext context, String label) => GestureDetector(
      onTap: () => onTagTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7E9F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
        ),
      ),
    );
}
