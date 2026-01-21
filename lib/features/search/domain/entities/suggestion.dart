import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  final String text;
  final SuggestionType type;
  final String? subtitle; 
  final Map<String, dynamic>? meta;

  const Suggestion({
    required this.text,
    this.type = SuggestionType.keyword,
    this.subtitle,
    this.meta,
  });

  @override
  List<Object?> get props => [text, type, subtitle, meta];
}

enum SuggestionType { keyword, brand, category, history, other }
