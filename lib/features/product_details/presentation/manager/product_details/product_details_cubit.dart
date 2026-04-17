import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../products/domain/entities/product_entity.dart';
import '../../../domain/usecases/get_product_details.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.getProductDetails) : super(ProductDetailsInitial());
  final GetProductDetailsUseCase getProductDetails;

  void _safeEmit(ProductDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> loadProductDetails(
      {String? id, ProductEntity? initialProduct, bool refresh = false}) async {
    if (initialProduct != null && !refresh) {
      _safeEmit(ProductDetailsLoaded(initialProduct));
      return;
    }

    if (id == null) {
      _safeEmit(const ProductDetailsError('No product id provided'));
      return;
    }

    _safeEmit(ProductDetailsLoading());
    final res = await getProductDetails.call(id);
    if (isClosed) return;
    res.fold(
      (failure) => _safeEmit(ProductDetailsError(failure.message)),
      (product) => _safeEmit(ProductDetailsLoaded(product)),
    );
  }
}
