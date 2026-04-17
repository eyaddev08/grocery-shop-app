import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }
enum ProductSource { all, category, recommended, deals }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> allProducts;
  final List<ProductEntity> originalProducts;
  final List<ProductEntity> recommendedProducts;
  final List<ProductEntity> dealsProducts;
  final String errorMessage;
  
  final List<String> filters;
  final int selectedFilterIndex;

  const ProductState({
    this.status = ProductStatus.initial,
    this.allProducts = const [],
    this.originalProducts = const [],
    this.recommendedProducts = const [],
    this.dealsProducts = const [],
    this.errorMessage = '',
    this.filters = const ['All'],
    this.selectedFilterIndex = 0,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? allProducts,
    List<ProductEntity>? originalProducts,
    List<ProductEntity>? recommendedProducts,
    List<ProductEntity>? dealsProducts,
    String? errorMessage,
    List<String>? filters,
    int? selectedFilterIndex,
  }) => ProductState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      originalProducts: originalProducts ?? this.originalProducts,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      dealsProducts: dealsProducts ?? this.dealsProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      filters: filters ?? this.filters,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
    );

  @override
  List<Object?> get props => [
        status,
        allProducts,
        originalProducts,
        recommendedProducts,
        dealsProducts,
        errorMessage,
        filters,
        selectedFilterIndex,
      ];
}