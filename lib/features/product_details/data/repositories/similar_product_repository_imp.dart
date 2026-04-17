import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/similar_product_repository.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../products/domain/entities/product_entity.dart';

class SimilarProductRepositoryImpl implements SimilarProductRepository {
  SimilarProductRepositoryImpl(this.productRepository);
  final ProductRepository productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, {int limit = 6}) async {
    try {
      final baseProductRes = await productRepository.getProductById(id);
      
      return await baseProductRes.fold(
        (failure) async => Left(failure),
        (baseProduct) async {
          
          Either<Failure, List<ProductEntity>> targetListResponse;
          if (id.startsWith('rec_')) {
            targetListResponse = await productRepository.getRecommendedProducts();
          } else if (id.startsWith('deal_')) {
            targetListResponse = await productRepository.getDealsProducts();
          } else {
            targetListResponse = await productRepository.getProducts();
          }

          return targetListResponse.fold(
            (failure) async => Left(failure),
            (poolProducts) {
              final availableProducts = poolProducts.where((p) => p.id != id).toList();
              final Set<ProductEntity> similarProducts = {};

              if (baseProduct.categoryIds.isNotEmpty) {
                similarProducts.addAll(availableProducts.where(
                  (p) => p.categoryIds.any((catId) => baseProduct.categoryIds.contains(catId))
                ).take(limit));
              }

              if (similarProducts.length < limit && baseProduct.brand != null) {
                similarProducts.addAll(availableProducts.where(
                  (p) => p.brand?.toLowerCase() == baseProduct.brand?.toLowerCase()
                ).take(limit - similarProducts.length));
              }

              if (similarProducts.length < limit) {
                similarProducts.addAll(availableProducts.take(limit - similarProducts.length));
              }

              return Right(similarProducts.toList());
            },
          );
        },
      );
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}