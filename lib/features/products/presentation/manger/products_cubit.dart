import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import 'products_state.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProducts) : super(ProductsInitial());
  final GetProducts getProducts;

  Future<void> load() async {
    _safeEmit(ProductsLoading());
    final Either<Failure, List<Product>> res = await getProducts();
    if (isClosed) return;
    res.fold((l) => _safeEmit(ProductsError(l.message)), (r) {
      _allProducts = List<Product>.from(r);
      filterIndex = 0;
      _safeEmit(ProductsLoaded(List<Product>.from(_allProducts)));
    });
  }

  int filterIndex = 0;

  List<Product> _allProducts = [];

  List<String> get filters {
    final List<String> labels = [];
    for (final p in _allProducts) {
      final lbl = (p.filterLabel ?? '').trim();
      if (lbl.isEmpty) continue;
      if (!labels.contains(lbl)) labels.add(lbl);
    }
    return ['All', ...labels];
  }

  Future<void> filterProducts(int idx) async {
    if (_allProducts.isEmpty) return;
    final List<String> available = filters;
    if (idx < 0 || idx >= available.length) return;
    filterIndex = idx;
    final label = available[idx];
    if (label == 'All') {
      _safeEmit(ProductsLoaded(List<Product>.from(_allProducts)));
      return;
    }
    final filtered =
        _allProducts.where((p) => (p.filterLabel ?? '') == label).toList();
    _safeEmit(ProductsLoaded(filtered));
  }

  // helper to avoid emitting after close
  void _safeEmit(ProductsState state) {
    if (!isClosed) emit(state);
  }
}
