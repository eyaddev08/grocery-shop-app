part of 'grocery_cubit.dart';

abstract class GroceryState {
const GroceryState();
}


class GroceryInitial extends GroceryState {
const GroceryInitial();
}


class GroceryLoading extends GroceryState {
const GroceryLoading();
}


class GroceryLoaded extends GroceryState {
const GroceryLoaded(this.products);
final List<dynamic> products;
}


class GroceryError extends GroceryState {
final String message;
const GroceryError(this.message);
}