import 'package:hive/hive.dart';


import '../models/suggestion_model.dart';
import '../models/search_result_model.dart';

abstract class SearchLocalDataSource {
  Future<void> cacheSuggestions(List<SuggestionModel> suggestions);

  Future<List<SuggestionModel>> getCachedSuggestions();

  Future<void> cacheLastResult(SearchResultModel result);

  Future<SearchResultModel?> getLastResult();

  Future<void> addSearchToHistory(String query);

  Future<List<String>> getSearchHistory();

  Future<void> clearSearchHistory();

  Future<void> removeSearchHistoryItem(String query);

}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final Box<dynamic> box;

  static const _kSuggestionsKey = 'search_suggestions';
  static const _kLastResultKey = 'search_last_result';
  static const _kHistoryKey = 'search_history';

  SearchLocalDataSourceImpl(this.box);


  // Helper: read raw value or default
  dynamic _getBoxValue(String key) => box.get(key);

  @override
  Future<void> cacheSuggestions(List<SuggestionModel> suggestions) async {
    try {
      final List<Map<String, dynamic>> list =
          suggestions.map((s) => s.toJson()).toList();
      await box.put(_kSuggestionsKey, list);
    } catch (_) {}
  }

  @override
  Future<List<SuggestionModel>> getCachedSuggestions() async {
    try {
      final raw = box.get(_kSuggestionsKey);
      if (raw is List) {
        return raw
            .map((e) {
              if (e is Map)
                return SuggestionModel.fromJson(Map<String, dynamic>.from(e));
              return null;
            })
            .whereType<SuggestionModel>()
            .toList();
      }
    } catch (_) {}
    return <SuggestionModel>[];
  }

  @override
  Future<void> cacheLastResult(SearchResultModel result) async {
    try {
      await box.put(_kLastResultKey, result.toJson());
    } catch (_) {}
  }

  @override
  Future<SearchResultModel?> getLastResult() async {
    try {
      final raw = box.get(_kLastResultKey);
      if (raw is Map) {
        return SearchResultModel.fromJson(Map<String, dynamic>.from(raw));
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<void> addSearchToHistory(String query) async {
    try {
      final raw = box.get(_kHistoryKey);

      List<String> history = [];
      if (raw is List) {
        history = raw.map((e) => e.toString()).toList();
      }

      history.removeWhere((x) => x.toLowerCase() == query.toLowerCase());
      history.insert(0, query);
      if (history.length > 20) history = history.sublist(0, 20);

      await box.put(_kHistoryKey, history);

    } catch (e) {}
  }

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      final raw = box.get(_kHistoryKey);
      if (raw is List) return raw.map((e) => e.toString()).toList();
    } catch (_) {}
    return <String>[];
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      await box.delete(_kHistoryKey);
    } catch (_) {}
  }

  @override
  Future<void> removeSearchHistoryItem(String query) async {
    try {
      final raw = box.get(_kHistoryKey);
      List<String> history = [];
      if (raw is List) {
        history = raw.map((e) => e.toString()).toList();
      }
      history.removeWhere((x) => x.toLowerCase() == query.toLowerCase());
      await box.put(_kHistoryKey, history);
    } catch (_) {}
  }
}
