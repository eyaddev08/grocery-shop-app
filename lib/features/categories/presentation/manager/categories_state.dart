import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  const CategoriesLoaded(this.categories);
  @override
  List<Object?> get props => [categories];
}

class CategoriesFiltered extends CategoriesState {
  const CategoriesFiltered(this.filterIndex);
  final int filterIndex;
  @override
  List<Object?> get props => [filterIndex];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object?> get props => [message];
}
