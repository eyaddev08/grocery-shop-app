import '../entities/product.dart';
import '../repositories/product_repository.dart';


class GetProductsUseCase {
GetProductsUseCase(this.repository);
final ProductRepository repository;


Future<List<Product>> call() async => await repository.fetchProducts();
}