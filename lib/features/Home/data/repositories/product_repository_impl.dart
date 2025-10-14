import 'dart:async';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(milliseconds: 450));

    final raw = [
      {'id': 'p1', 'title': 'Orange Package 1 | 1 bundle', 'price': r'$325'},
      {'id': 'p2', 'title': 'Green Tea Package 2 | 1 bundle', 'price': r'$89'},
      {'id': 'p3', 'title': 'Apple Pack | 3 kg', 'price': r'$120'},
      {'id': 'p4', 'title': 'Black Tea | 1 pack', 'price': r'$45'},
    ];

    return raw.map(ProductModel.fromMap).toList();
  }
}
