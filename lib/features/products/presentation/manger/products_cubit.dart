import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'products_state.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProducts) : super(ProductsInitial());
  final GetProducts getProducts;

  List<ProductEntity> _allProducts = []; // full products from repository
  List<ProductEntity> _baseProducts =
      []; // base set for current screen (e.g., filtered by category)
  int filterIndex = 0;

  Future<void> loadProducts({String? categoryId}) async {
    _safeEmit(ProductsLoading());
    final Either<Failure, List<ProductEntity>> res = await getProducts();
    if (isClosed) return;
    res.fold((l) => _safeEmit(ProductsError(l.message)), (r) {
      _allProducts = List<ProductEntity>.from(r);

      // Build _baseProducts: if categoryId provided, filter _allProducts locally
      if (categoryId != null && categoryId.isNotEmpty) {
        _baseProducts = _allProducts.where((p) {
          final catIds =
              p.categoryIds.map((e) => e.toString()).toList();
          return catIds.contains(categoryId);
        }).toList();
      } else {
        _baseProducts = List<ProductEntity>.from(_allProducts);
      }
      // If no products in base -> emit empty state
      if (_baseProducts.isEmpty) {
        emit(const ProductsEmpty(message: 'No products in this category'));
        return;
      }

      filterIndex = 0;
      _safeEmit(ProductsLoaded(List<ProductEntity>.from(_baseProducts)));
    });
  }

  List<String> get filters {
    // filters are based on filterLabel inside the baseProducts (so chips apply to current base)
    final List<String> labels = [];
    for (final p in _baseProducts) {
      final lbl = (p.filterLabel ?? '').trim();
      if (lbl.isEmpty) continue;
      if (!labels.contains(lbl)) labels.add(lbl);
    }
    return ['All', ...labels];
  }

  Future<void> filterProducts(int idx) async {
    if (_baseProducts.isEmpty) return;
    final List<String> available = filters;
    if (idx < 0 || idx >= available.length) return;
    filterIndex = idx;
    final label = available[idx];
    if (label == 'All') {
      _safeEmit(ProductsLoaded(List<ProductEntity>.from(_baseProducts)));
      return;
    }
    final filtered =
        _baseProducts.where((p) => (p.filterLabel ?? '') == label).toList();
    _safeEmit(ProductsLoaded(filtered));
  }

  void _safeEmit(ProductsState state) {
    if (!isClosed) emit(state);
  }
}

// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit(this.getProducts) : super(ProductsInitial());
//   final GetProducts getProducts;

//   Future<void> load() async {
//     _safeEmit(ProductsLoading());
//     final Either<Failure, List<ProductEntity>> res = await getProducts();
//     if (isClosed) return;
//     res.fold((l) => _safeEmit(ProductsError(l.message)), (r) {
//       _allProducts = List<ProductEntity>.from(r);
//       filterIndex = 0;
//       _safeEmit(ProductsLoaded(List<ProductEntity>.from(_allProducts)));
//     });
//   }

//   int filterIndex = 0;

//   List<ProductEntity> _allProducts = [];

//   List<String> get filters {
//     final List<String> labels = [];
//     for (final p in _allProducts) {
//       final lbl = (p.filterLabel ?? '').trim();
//       if (lbl.isEmpty) continue;
//       if (!labels.contains(lbl)) labels.add(lbl);
//     }
//     return ['All', ...labels];
//   }

//   Future<void> filterProducts(int idx) async {
//     if (_allProducts.isEmpty) return;
//     final List<String> available = filters;
//     if (idx < 0 || idx >= available.length) return;
//     filterIndex = idx;
//     final label = available[idx];
//     if (label == 'All') {
//       _safeEmit(ProductsLoaded(List<ProductEntity>.from(_allProducts)));
//       return;
//     }
//     final filtered =
//         _allProducts.where((p) => (p.filterLabel ?? '') == label).toList();
//     _safeEmit(ProductsLoaded(filtered));
//   }

//   // helper to avoid emitting after close
//   void _safeEmit(ProductsState state) {
//     if (!isClosed) emit(state);
//   }
// }
