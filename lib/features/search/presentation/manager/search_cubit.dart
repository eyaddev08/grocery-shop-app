import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_search_suggestions.dart';
import '../../domain/usecases/search_products.dart';
import '../../domain/usecases/clear_search_history.dart';
import '../../domain/usecases/remove_search_history_item.dart';
import '../../domain/entities/search_result.dart';
import '../../../../core/utils/debounce.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchSuggestionsUseCase getSearchSuggestions;
  final SearchProducts searchProducts;
  final ClearSearchHistoryUseCase clearSearchHistory;
  final RemoveSearchHistoryItemUseCase removeSearchHistoryItem;

  late Debounce _suggestionsDebounce;
  late Debounce _searchDebounce;

  Map<String, dynamic> get selectedFilters => Map.unmodifiable(_currentFilters);
  String get currentSort => _sortBy ?? 'relevance';

  SearchCubit({
    required this.getSearchSuggestions,
    required this.searchProducts,
    required this.clearSearchHistory,
    required this.removeSearchHistoryItem,
  }) : super(SearchInitial()) {
    _suggestionsDebounce = Debounce(delay: const Duration(milliseconds: 300));
    _searchDebounce = Debounce(delay: const Duration(milliseconds: 300));

    // Load recent suggestions (history) immediately so UI can show something
    Future.microtask(() => loadSuggestions(''));
  }

  Future<void> executeSearch(String query, {bool isNewSearch = true}) async {
    if (query.isEmpty) {
      return;
    }

    _suggestionsDebounce.dispose(); // cancel pending suggestions

    if (isNewSearch) {
      _lastQuery = query;
      emit(const SearchLoading());
    }

    final currentState = state;
    String? cursor;
    if (!isNewSearch && currentState is SearchLoaded) {
      cursor = currentState.result.nextCursor;
      if (cursor == null) return; // no more pages
      emit(currentState.copyWith(isPaginationLoading: true));
    }

    final params = SearchProductsParamsUseCase(
      query: _lastQuery,
      filters: _currentFilters.isEmpty
          ? null
          : Map<String, dynamic>.from(_currentFilters),
      cursor: cursor,
      sort: _sortBy ?? 'relevance',
    );
    final result = await searchProducts(params);

    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (newResult) {
        if (!isNewSearch && currentState is SearchLoaded) {
          final mergedResult = SearchResult(
            products: [...currentState.result.products, ...newResult.products],
            total: newResult.total,
            nextCursor: newResult.nextCursor,
            facets: newResult.facets,
            limit: newResult.limit,
            cursor: newResult.cursor,
          );
          emit(SearchLoaded(result: mergedResult));
        } else {
          if (newResult.products.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchLoaded(result: newResult));
          }
        }
      },
    );
  }

  // add method to toggle single filter (helper)
  void toggleFilter(String key, String value) {
    final newFilters = Map<String, dynamic>.from(_currentFilters);
    if (newFilters[key] == value) {
      newFilters.remove(key);
    } else {
      newFilters[key] = value;
    }
    updateFilters(newFilters);
  }

  // Current search params state
  String _lastQuery = '';
  Map<String, dynamic> _currentFilters = {};
  String? _sortBy;

  void onQueryChanged(String query) {
    if (query.isEmpty) {
      loadSuggestions(''); // Fetch history
      return;
    }

    if (query.length < 2) return;

    _suggestionsDebounce.run(() {
      loadSuggestions(query);
    });
  }

  Future<void> loadSuggestions(String query) async {
    emit(SearchSuggestionsLoading());
    final result = await getSearchSuggestions(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (suggestions) {
        emit(SearchSuggestionsLoaded(suggestions));
      },
    );
  }

  Future<void> clearHistory() async {
    await clearSearchHistory();
    loadSuggestions('');
  }

  Future<void> removeHistoryItem(String item) async {
    await removeSearchHistoryItem(item);
    loadSuggestions(''); // Refresh history view
  }

  void updateFilters(Map<String, dynamic> filters) {
    _currentFilters = filters;
    executeSearch(_lastQuery);
  }

  void updateSort(String sort) {
    _sortBy = sort;
    executeSearch(_lastQuery);
  }

  void loadNextPage() {
    if (state is SearchLoaded) {
      executeSearch(_lastQuery, isNewSearch: false);
    }
  }

  void resetSearch() {
    _lastQuery = '';
    _currentFilters = {};
    _sortBy = null;
    loadSuggestions('');
  }

  @override
  Future<void> close() {
    _suggestionsDebounce.dispose();
    _searchDebounce.dispose();
    return super.close();
  }
}
