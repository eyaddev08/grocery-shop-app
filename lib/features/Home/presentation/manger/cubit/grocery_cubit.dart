
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_products_usecase.dart';

part 'grocery_state.dart';


class GroceryCubit extends Cubit<GroceryState> {
GroceryCubit(this.getProductsUseCase) : super(const GroceryInitial());
final GetProductsUseCase getProductsUseCase;


Future<void> loadProducts() async {
emit(const GroceryLoading());
try {
final items = await getProductsUseCase();
emit(GroceryLoaded(items));
} catch (e) {
emit(GroceryError(e.toString()));
}
}
}