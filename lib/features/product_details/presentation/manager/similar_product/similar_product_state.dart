part of 'similar_product_cubit.dart';

sealed class SimilarProductState extends Equatable {
  const SimilarProductState();

  @override
  List<Object> get props => [];
}

class SimilarProductInitial extends SimilarProductState {}

class SimilarProductLoading extends SimilarProductState {}

class SimilarProductLoaded extends SimilarProductState {
  const SimilarProductLoaded(this.products);
  final List<SimilarProduct> products;
}

class SimilarProductError extends SimilarProductState {
  const SimilarProductError(this.message);
  final String message;
}
