// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../orders/domain/entities/order_entity.dart';
// import '../../../../domain/usecases/track_order_search.dart';

// part 'track_order_search_state.dart';

// class TrackOrderSearchCubit extends Cubit<TrackOrderSearchState> {

//   TrackOrderSearchCubit(this.trackOrderUseCase) : super(TrackOrderSearchInitial());
//  final TrackOrderSearchUseCase trackOrderUseCase;

//   Future<void> searchOrderForTracking(String orderId, String phone) async {
//     emit(TrackOrderSearchLoading());

//     final result =
//      await trackOrderUseCase(orderId, phone);

//     result.fold(
//       (failure) => emit(TrackOrderSearchError(failure.message)),
//       (order) => emit(TrackOrderSearchSuccess(order)), 
//     );
//   }
// }
