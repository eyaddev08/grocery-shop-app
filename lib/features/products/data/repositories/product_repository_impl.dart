import '../../../products/domain/entities/product.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _sample = [
    const Product(
        id: 'p1',
        title: 'Clownfish',
        subtitle: 'Sea fish',
        filterLabel: 'Popular',
        price: 89,
        image: 'assets/images/vegetables_image.jpg'),
    const Product(
        id: 'p2',
        title: 'Gold Fish',
        subtitle: 'Fresh',
        filterLabel: 'Low Price',
        price: 325,
        image: 'assets/images/vegetables_image.jpg'),
    const Product(
        id: 'p3',
        title: 'Tang',
        subtitle: 'Big tang',
        filterLabel: 'Small Fishes',
        price: 325,
        image: 'assets/images/nutrition-healthy-fin-animal-uncooked.jpg'),
    const Product(
        id: 'p4',
        title: 'Clownfish',
        subtitle: 'Sea fish',
        filterLabel: 'Big',
        price: 89,
        image: null),
    const Product(
        id: 'p5',
        title: 'Gold Fish',
        subtitle: 'Fresh',
        filterLabel: '',
        price: 325,
        image: null),
    const Product(
        id: 'p6',
        title: 'Tang',
        subtitle: 'Big tang',
        filterLabel: '',
        price: 325,
        image: null),
  ];

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    return Right(_sample);
  }
}
