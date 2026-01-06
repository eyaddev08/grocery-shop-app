import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/recommended_product.dart';
import '../../../domain/usecases/get_recommended_products.dart';

part 'recommended_state.dart';

class RecommendedCubit extends Cubit<RecommendedState> {
  RecommendedCubit(this.getRecommended) : super(const RecommendedInitial());
  final GetRecommendedProducts getRecommended;

  Future<void> load() async {
    emit(const RecommendedLoading());
    final res = await getRecommended();
    res.fold((f) => emit(RecommendedError(f.message)),
        (items) => emit(RecommendedLoaded(items)));
  }
}
