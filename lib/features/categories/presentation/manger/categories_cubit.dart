import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_categories.dart';
import 'categories_state.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/category.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategories getCategories;
  CategoriesCubit(this.getCategories) : super(CategoriesInitial());

  Future<void> load() async {
    emit(CategoriesLoading());
    final Either<Failure, List<Category>> res = await getCategories();
    if (res is Left<Failure, List<Category>>) {
      final Failure f = (res as Left<Failure, List<Category>>).value;
      emit(CategoriesError(f.message));
      return;
    }
    if (res is Right<Failure, List<Category>>) {
      final items = (res as Right<Failure, List<Category>>).value;
      emit(CategoriesLoaded(List<Category>.from(items)));
      return;
    }
    emit(const CategoriesError('Unknown error'));
  }
}
