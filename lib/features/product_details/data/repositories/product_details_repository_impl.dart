// data/repositories/product_details_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../../domain/repositories/product_details_repository.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../products/domain/entities/product_entity.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {

  ProductDetailsRepositoryImpl(this.productRepository);
  final ProductRepository productRepository;

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String id) async {
    try {
      // 1) إن كان ProductRepository يوفر getProductById افتحها أولاً (أسرع)
      if (productRepository is ProductRepositoryWithById) {
        final res = await (productRepository as ProductRepositoryWithById).getProductById(id);
        if (res.isRight()) return res;
        // إذا فشل (مثلاً لم يجده) لنعود للخطوة التالية
      }

      // 2) جلب كل المنتجات والبحث محليًا (fallback)
      final eitherAll = await productRepository.getProducts();
      return eitherAll.fold(
        (failure) => Left(failure),
        (list) {
          final ProductEntity? found = _findById(list, id);
          if (found == null) {
            return Left(ServerFailure(message: 'Product not found'));
          }
          return Right(found);
        },
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  ProductEntity? _findById(List<ProductEntity> list, String id) {
    for (final p in list) {
      if (p.id.toString() == id.toString()) return p;
    }
    return null;
  }
}

/// optional: واجهة توسيعية إن أردت ProductRepository يدعم الاستعلام حسب id مباشرة
abstract class ProductRepositoryWithById implements ProductRepository {
  Future<Either<Failure, ProductEntity>> getProductById(String id);
}
