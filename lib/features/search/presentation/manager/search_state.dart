import 'package:equatable/equatable.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/entities/suggestion.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchSuggestionsLoading extends SearchState {}

class SearchSuggestionsLoaded extends SearchState {
  const SearchSuggestionsLoaded(this.suggestions);
  final List<Suggestion> suggestions;
  @override
  List<Object?> get props => [suggestions];
}

class SearchLoading extends SearchState {
  const SearchLoading({this.currentResult});
  final SearchResult? currentResult;
}

class SearchLoaded extends SearchState {
  const SearchLoaded({required this.result, this.isPaginationLoading = false});
  final SearchResult result;
  final bool isPaginationLoading;

  SearchLoaded copyWith({
    SearchResult? result,
    bool? isPaginationLoading,
  }) =>
      SearchLoaded(
        result: result ?? this.result,
        isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      );

  @override
  List<Object?> get props => [result, isPaginationLoading];
}

class SearchError extends SearchState {
  const SearchError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class SearchEmpty extends SearchState {}
