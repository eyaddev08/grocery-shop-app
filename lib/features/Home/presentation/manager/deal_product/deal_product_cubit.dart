import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/deal_product.dart';
import '../../../domain/usecases/get_deal_products.dart';

part 'deal_product_state.dart';

class DealProductCubit extends Cubit<DealProductState> {
  DealProductCubit(this.getProductsUseCase) : super(const DealProductInitial());
  final GetDealProductsUseCase getProductsUseCase;

  Future<void> loadProducts() async {
    emit(const DealProductLoading());
    final result = await getProductsUseCase();

    result.fold(
      (failure) => emit(DealProductError(failure.message)),
      (product) => emit(DealProductLoaded(product)),
    );
  }
}
