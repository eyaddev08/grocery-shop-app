import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product_details.dart';
import '../../../domain/usecases/get_product_details.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.getProductDetails}) : super(ProductDetailsInitial());

  final GetProductDetails getProductDetails;

  

  void _safeEmit(ProductDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> load(String id) async {
    _safeEmit(ProductDetailsLoading());
    final result = await getProductDetails.call(id);
    if (isClosed) return;
    result.fold((s) => _safeEmit(ProductDetailsError(s.message)),
        (details) => _safeEmit(ProductDetailsLoaded(details)));
  }
}
