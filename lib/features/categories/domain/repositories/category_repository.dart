import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
}
