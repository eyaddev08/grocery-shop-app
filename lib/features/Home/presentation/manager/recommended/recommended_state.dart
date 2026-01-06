part of 'recommended_cubit.dart';

abstract class RecommendedState {
  const RecommendedState();
}

class RecommendedInitial extends RecommendedState {
  const RecommendedInitial();
}

class RecommendedLoading extends RecommendedState {
  const RecommendedLoading();
}

class RecommendedLoaded extends RecommendedState {
  const RecommendedLoaded(this.items);
  final List<RecommendedProduct> items;
}

class RecommendedError extends RecommendedState {
  const RecommendedError(this.message);
  final String message;
}
