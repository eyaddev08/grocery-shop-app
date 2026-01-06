// data/repositories/similar_product_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../../domain/repositories/similar_product_repository.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../products/domain/entities/product_entity.dart';

class SimilarProductRepositoryImpl implements SimilarProductRepository {

  SimilarProductRepositoryImpl(this.productRepository);
  final ProductRepository productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> getSimilarProducts(String id, {int limit = 6})  async{
      try {
      final Either<Failure, List<ProductEntity>> res = await productRepository.getProducts();

      return await res.fold(
        (failure) async => Left(failure),
        (products) async {
          final baseList = products.where((p) => p.id.toString() == id.toString()).toList();
          if (baseList.isEmpty) {
            return Left(ServerFailure(message: 'Base product not found'));
          }
          final base = baseList.first;

          final Set<ProductEntity> found = {};

          // 1) منتجات بنفس الفئات (categoryIds)
          if (base.categoryIds.isNotEmpty) {
            for (final catId in base.categoryIds) {
              for (final p in products) {
                if (p.id.toString() == base.id.toString()) continue;
                if (p.categoryIds.contains(catId)) {
                  found.add(p);
                  if (found.length >= limit) break;
                }
              }
              if (found.length >= limit) break;
            }
          }

          // 2) إن لم يكفّ، منتجات بنفس الماركة
          if (found.length < limit && base.brand != null && base.brand!.trim().isNotEmpty) {
            for (final p in products) {
              if (p.id.toString() == base.id.toString()) continue;
              if (p.brand != null && p.brand!.toLowerCase() == base.brand!.toLowerCase()) {
                found.add(p);
                if (found.length >= limit) break;
              }
            }
          }

          // 3) كاحتياط: أي منتجات أخرى تختلف عن الأساسي
          if (found.length < limit) {
            for (final p in products) {
              if (p.id.toString() == base.id.toString()) continue;
              found.add(p);
              if (found.length >= limit) break;
            }
          }

          return Right(found.toList().take(limit).toList());
        },
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
