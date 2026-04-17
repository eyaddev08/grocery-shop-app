import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_deals_products.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/get_recommended_products.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetRecommendedProductsUseCase getRecommendedUseCase;
  final GetDealsProductsUseCase getDealsUseCase;

  ProductCubit({
    required this.getProductsUseCase,
    required this.getRecommendedUseCase,
    required this.getDealsUseCase,
  }) : super(const ProductState());

  Future<void> loadHomeScreenData() async {
    emit(state.copyWith(status: ProductStatus.loading));

    final results = await Future.wait([
      getProductsUseCase(),
      getRecommendedUseCase(),
      getDealsUseCase(),
    ]);

    Failure? encounteredFailure;
    List<ProductEntity> fetchedAll = [];
    List<ProductEntity> fetchedRecommended = [];
    List<ProductEntity> fetchedDeals = [];

    results[0].fold((l) => encounteredFailure = l, (r) => fetchedAll = r as List<ProductEntity>);
    results[1].fold((l) => encounteredFailure ??= l, (r) => fetchedRecommended = r as List<ProductEntity>);
    results[2].fold((l) => encounteredFailure ??= l, (r) => fetchedDeals = r as List<ProductEntity>);

    if (encounteredFailure != null) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: encounteredFailure!.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: ProductStatus.loaded,
      allProducts: fetchedAll,
      recommendedProducts: fetchedRecommended,
      dealsProducts: fetchedDeals,
    ));
  }

  Future<void> fetchProductsBySource({
    required ProductSource source,
    int? categoryId,
  }) async {
    emit(state.copyWith(
      status: ProductStatus.loading,
      selectedFilterIndex: 0,
      filters: ['All'],
    ));

    Either<Failure, List<ProductEntity>> result;

    switch (source) {
      case ProductSource.recommended:
        result = await getRecommendedUseCase();
        break;
      case ProductSource.deals:
        result = await getDealsUseCase();
        break;
      case ProductSource.category:
        final allProductsResult = await getProductsUseCase();
        result = allProductsResult.fold(
          (failure) => Left(failure),
          (products) {
            final categoryProducts = products.where((p) => p.categoryIds.contains(categoryId)).toList();
            return Right(categoryProducts);
          },
        );
        break;
      case ProductSource.all:
      default:
        result = await getProductsUseCase();
        break;
    }

    result.fold(
      (failure) => emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: failure.message,
      )),
      (products) {
        final Set<String> extractedFilters = {'All'};

        for (final product in products) {
          if (product.filterLabel != null && product.filterLabel!.trim().isNotEmpty) {
            extractedFilters.add(product.filterLabel!.trim());
          }
        }

        emit(state.copyWith(
          status: ProductStatus.loaded,
          originalProducts: products,
          allProducts: products,
          filters: extractedFilters.toList(),
        ));
      },
    );
  }

  void filterProducts(int index) {
    if (index < 0 || index >= state.filters.length) return;

    final selectedFilter = state.filters[index];
    final isAll = selectedFilter.toLowerCase() == 'all';

    final resultList = isAll
        ? List<ProductEntity>.from(state.originalProducts)
        : state.originalProducts
            .where((p) => p.filterLabel?.toLowerCase() == selectedFilter.toLowerCase())
            .toList();

    emit(state.copyWith(
      selectedFilterIndex: index,
      allProducts: resultList,
    ));
  }

  Future<void> loadProducts() async {
    await fetchProductsBySource(source: ProductSource.all);
  }
}