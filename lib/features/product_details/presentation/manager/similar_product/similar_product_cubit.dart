import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../products/domain/entities/product_entity.dart';
import '../../../domain/usecases/get_similar_product.dart';

part 'similar_product_state.dart';


class SimilarProductCubit extends Cubit<SimilarProductState> {
  SimilarProductCubit({required this.getSimilarProduct})
      : super(SimilarProductInitial());
  final GetSimilarProduct getSimilarProduct;

  void _safeEmit(SimilarProductState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> load(String id, {int limit = 6}) async {
    _safeEmit(SimilarProductLoading());
    final result = await getSimilarProduct.call(id, limit: limit);

    if (isClosed) return;

    result.fold(
      (f) => _safeEmit(SimilarProductError(f.message)),
      (similar) => _safeEmit(SimilarProductLoaded(similar)),
    );
  }
}
