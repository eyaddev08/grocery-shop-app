import 'dart:convert';

import '../../domain/entities/suggestion.dart';

class SuggestionModel extends Suggestion {
  const SuggestionModel({
    required super.text,
    super.type,
    super.subtitle,
    super.meta,
  });

  factory SuggestionModel.fromJson(dynamic json) {
    if (json == null) return const SuggestionModel(text: '');

    if (json is String) return SuggestionModel(text: json);

    if (json is Map) {
      final txt = (json['text'] ?? json['name'] ?? json['title'])?.toString() ?? '';
      final tRaw = (json['type'] ?? json['kind'])?.toString().toLowerCase() ?? 'keyword';
      final SuggestionType t = (tRaw == 'brand')
          ? SuggestionType.brand
          : (tRaw == 'category')
              ? SuggestionType.category
              : SuggestionType.keyword;

      final subtitle = json['subtitle']?.toString();

      final dynamic metaRaw = json['meta'];
      final Map<String, dynamic>? meta = (metaRaw is Map) ? Map<String, dynamic>.from(metaRaw as Map) : null;

      return SuggestionModel(text: txt, type: t, subtitle: subtitle, meta: meta);
    }

    if (json is String) {
      final parsed = _tryJsonDecode(json);
      if (parsed is Map) return SuggestionModel.fromJson(parsed);
    }

    return SuggestionModel(text: json.toString());
  }

  Map<String, dynamic> toJson() => {
      'text': text,
      'type': type.name,
      if (subtitle != null) 'subtitle': subtitle,
      if (meta != null) 'meta': meta,
    };

  static dynamic _tryJsonDecode(String s) {
    try {
      return jsonDecode(s);
    } catch (_) {
      return null;
    }
  }

  static List<SuggestionModel> fromJsonList(List<dynamic> list) => list.map(SuggestionModel.fromJson).toList();
}

