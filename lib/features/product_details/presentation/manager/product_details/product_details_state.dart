part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded(this.details);
  final ProductDetails details;
}

class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError(this.message);
  final String message;
}
