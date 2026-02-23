import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../products/domain/entities/product_entity.dart';
import '../../../domain/usecases/get_product_details.dart';

part 'product_details_state.dart';

// class ProductDetailsCubit extends Cubit<ProductDetailsState> {
//   ProductDetailsCubit({required this.getProductDetails}) : super(ProductDetailsInitial());

//   final GetProductDetails getProductDetails;

//   void _safeEmit(ProductDetailsState state) {
//     if (isClosed) return;
//     emit(state);
//   }

//   Future<void> load(String id) async {
//     _safeEmit(ProductDetailsLoading());
//     final result = await getProductDetails.call(id);
//     if (isClosed) return;
//     result.fold((s) => _safeEmit(ProductDetailsError(s.message)),
//         (details) => _safeEmit(ProductDetailsLoaded(details)));
//   }
// }

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.getProductDetails) : super(ProductDetailsInitial());
  final GetProductDetails getProductDetails;

  Future<void> load(
      {String? id, ProductEntity? initialProduct, bool refresh = false}) async {
    if (initialProduct != null && !refresh) {
      emit(ProductDetailsLoaded(initialProduct));
      return;
    }

    if (id == null) {
      emit(const ProductDetailsError('No product id provided'));
      return;
    }

    emit(ProductDetailsLoading());
    final res = await getProductDetails.call(id);
    res.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }
}
