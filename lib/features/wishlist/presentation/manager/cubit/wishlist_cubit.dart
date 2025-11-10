import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/wishlist_product.dart';
import '../../../domain/repositories/wishlist_repository.dart';
import '../../../domain/usecases/get_wishlist.dart';
import '../../../domain/usecases/remove_from_wishlist.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> { // used for toggleFavorite

  WishlistCubit({
    required GetWishlist getWishlist,
    required RemoveFromWishlist removeFromWishlist,
    required WishlistRepository repository,
  })  : _getWishlist = getWishlist,
        _removeFromWishlist = removeFromWishlist,
        _repo = repository,
        super(const WishlistInitial());
  final GetWishlist _getWishlist;
  final RemoveFromWishlist _removeFromWishlist;
  final WishlistRepository _repo;

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    final Either<Failure, List<WishlistProduct>> res = await _getWishlist();
    res.fold(
      (f) => emit(WishlistFailure(f.message)),
      (list) {
        if (list.isEmpty) {
          emit(const WishlistEmpty());
        } else {
          emit(WishlistLoaded(list));
        }
      },
    );
  }

  Future<void> remove(String productId) async {
    emit(const WishlistLoading());
    final Either<Failure, List<WishlistProduct>> res = await _removeFromWishlist(productId);
    res.fold(
      (f) => emit(WishlistFailure(f.message)),
      (list) {
        if (list.isEmpty) {
          emit(const WishlistEmpty());
        } else {
          emit(WishlistLoaded(list));
        }
      },
    );
  }

  Future<void> toggleFavorite(String productId) async {
    emit(const WishlistLoading());
    final Either<Failure, List<WishlistProduct>> res = await _repo.toggleFavorite(productId);
    res.fold(
      (f) => emit(WishlistFailure(f.message)),
      (list) {
        if (list.isEmpty) {
          emit(const WishlistEmpty());
        } else {
          emit(WishlistLoaded(list));
        }
      },
    );
  }
}

