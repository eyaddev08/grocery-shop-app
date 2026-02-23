import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/suggestion.dart';

class SuggestionsList extends StatelessWidget {
  final List<Suggestion> suggestions;
  final ValueChanged<String> onSuggestionSelected;

  const SuggestionsList({
    super.key,
    required this.suggestions,
    required this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SizedBox(height: 12),
          Text('Popular Tags',
              style:
                  textBold.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: suggestions.length,
      separatorBuilder: (_, __) => const Divider(
          color: kMutedGray, height: 1, indent: 72, endIndent: 16),
      itemBuilder: (context, index) {
        final s = suggestions[index];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFF2F5FF),
            child: Icon(_iconFor(s.type), color: kPrimaryBlue, size: 18),
          ),
          title: Text(s.text,
              style:
                  textBold.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.north_west, size: 16, color: kTextGray),
          onTap: () => onSuggestionSelected(s.text),
        );
      },
    );
  }

  IconData _iconFor(dynamic type) {
    try {
      if (type == null) return Icons.search;
      final t =
          type is String ? type.toLowerCase() : type.toString().toLowerCase();
      if (t.contains('history')) return Icons.history;
      if (t.contains('brand')) return Icons.branding_watermark;
      if (t.contains('category')) return Icons.category;
      return Icons.search;
    } catch (_) {
      return Icons.search;
    }
  }
}
