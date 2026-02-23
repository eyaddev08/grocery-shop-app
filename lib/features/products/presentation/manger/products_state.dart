import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);
  final List<ProductEntity> products;
  @override
  List<Object?> get props => [products];
}

class ProductsFiltered extends ProductsState {
  const ProductsFiltered(this.filterIndex);
  final int filterIndex;
  @override
  List<Object?> get props => [filterIndex];
}

class ProductsEmpty extends ProductsState {
  const ProductsEmpty({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}

class ProductsError extends ProductsState {
  const ProductsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
