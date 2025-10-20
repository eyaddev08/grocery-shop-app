import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';import '../../domain/entities/similar_product.dart';
import '../../domain/repositories/similar_product_repository.dart';

class SimilarProductRepositoryImpl implements SimilarProductRepository {
  @override
  Future<Either<Failure, List<SimilarProduct>>> getSimilarProduct(String id) async {
    try {
      // simulate network delay
      await Future<void>.delayed(const Duration(seconds: 5));

      List<SimilarProduct> similar = [
         SimilarProduct(
        id: '1',
        title: 'Fresh Apples',
        price: '3.49',
        image: 'assets/svg/empty_image.svg',
      ),
    
    const SimilarProduct(
        id: '2',
        title: 'Clownfish',
      
        price: '89',
         image: 'assets/svg/empty_image.svg',),
    const SimilarProduct(
        id: '3',
        title: 'Gold Fish',
     
        price: '325',
         image: 'assets/svg/empty_image.svg',),
    const SimilarProduct(
        id: '4',
        title: 'Tang',
    
        price: '325',
         image: 'assets/svg/empty_image.svg',),
    const SimilarProduct(
        id: '5',
        title: 'Clownfish',
       
        price: '89',
         image: 'assets/svg/empty_image.svg',),
    const SimilarProduct(
        id: '6',
        title: 'Gold Fish',
       
        price: '325',
         image: 'assets/svg/empty_image.svg',),
    const SimilarProduct(
        id: '7',
        title: 'Tang',
     
        price: '325',
         image: 'assets/svg/empty_image.svg',),
  ];

    
     

      return Right(similar);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
