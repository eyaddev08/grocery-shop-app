
import 'package:grocery_shop_app/features/Home/domain/entities/product.dart';

abstract class ProductRepository {
Future<List<Product>> fetchProducts();
}