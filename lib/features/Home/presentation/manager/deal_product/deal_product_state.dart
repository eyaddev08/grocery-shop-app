part of 'deal_product_cubit.dart';

abstract class DealProductState {
  const DealProductState();
}

class DealProductInitial extends DealProductState {
  const DealProductInitial();
}

class DealProductLoading extends DealProductState {
  const DealProductLoading();
}

class DealProductLoaded extends DealProductState {
  const DealProductLoaded(this.products);
  final List<DealsProduct> products;
}

class DealProductError extends DealProductState {
  final String message;
  const DealProductError(this.message);
}
