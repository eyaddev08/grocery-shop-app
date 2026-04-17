// import '../../../../core/error/failure.dart';
// import 'package:dartz/dartz.dart';
// import '../entities/product_entity.dart';
// import '../repositories/product_repository.dart';

// class GetProductsUseCase {
//   GetProductsUseCase(this.repository);
//   final ProductRepository repository;

//   Future<Either<Failure, List<ProductEntity>>> call() async =>
//       await repository.getProducts();
// }



// مثال لكيفية شكل الـ UseCase
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  GetProductsUseCase(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, List<ProductEntity>>> call({ProductParams? params}) async {
    final result = await repository.getProducts();
    
    return result.fold(
      (failure) async => Left(failure),
      (products) {
        if (params == null) return Right(products); 
        
        List<ProductEntity> filteredList = products;
        if (params.categoryId != null) {
          filteredList = filteredList.where((p) => p.categoryIds.contains(params.categoryId)).toList();
        }
        if (params.isOrganic) {
          filteredList = filteredList.where((p) => p.filterLabel == 'Organic').toList();
        }
        return Right(filteredList);
      }
    );
  }
}

class ProductParams {
  final String? categoryId;
  final bool isOrganic;
  
  ProductParams({this.categoryId, this.isOrganic = false});
}