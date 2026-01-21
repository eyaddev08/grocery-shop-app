

import 'package:flutter/material.dart';
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
          SizedBox(height: 12),
          Text('Popular Tags',
              style:
                  textBold.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: suggestions.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
      itemBuilder: (context, index) {
        final s = suggestions[index];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFF2F5FF),
            child: Icon(_iconFor(s.type),
                color: const Color(0xFF0A5ED3), size: 18),
          ),
          title: Text(s.text, style: textBold.copyWith(fontSize: 16)),
          trailing: const Icon(Icons.north_west, size: 16, color: Colors.grey),
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
