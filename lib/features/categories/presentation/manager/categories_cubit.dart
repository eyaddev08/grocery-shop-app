import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_categories.dart';
import 'categories_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/category.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.getCategories) : super(CategoriesInitial());
  final GetCategories getCategories;

  Future<void> loadCategories() async {
    emit(CategoriesLoading());
    final Either<Failure, List<Category>> res = await getCategories();
    if (isClosed) return;
    res.fold((l) => emit(CategoriesError(l.message)), (r) {
      _allCategorys = List<Category>.from(r);
      filterIndex = 0;
      emit(CategoriesLoaded(List<Category>.from(_allCategorys)));
    });
  }

  int filterIndex = 0;

  List<Category> _allCategorys = [];

  List<String> get filters {
    final List<String> labels = [];
    for (final p in _allCategorys) {
      final lbl = p.filterName.trim();
      if (lbl.isEmpty) continue;
      if (!labels.contains(lbl)) labels.add(lbl);
    }
    return ['All', ...labels];
  }
  

  Future<void> filterCategory(int idx) async {
    if (_allCategorys.isEmpty) return;
    final List<String> available = filters;
    if (idx < 0 || idx >= available.length) return;
    filterIndex = idx;
    final label = available[idx];
    if (label == 'All') {
      emit(CategoriesLoaded(List<Category>.from(_allCategorys)));
      return;
    }
    final filtered = _allCategorys.where((p) => p.filterName == label).toList();
    emit(CategoriesLoaded(filtered));
  }
}
