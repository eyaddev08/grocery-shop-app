/// Minimal Either implementation to avoid adding package dependency in this repo.
sealed class Either<L, R> {
  const Either();
}

class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}
