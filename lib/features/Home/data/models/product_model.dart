import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({required super.id, required super.title, required super.price});

  factory ProductModel.fromMap(Map<String, String> m) => ProductModel(
        id: m['id'] ?? '',
        title: m['title'] ?? '',
        price: m['price'] ?? '',
      );

  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'price': price};
}
