import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/wishlist_product_entity.dart';
import '../../../domain/usecases/get_wishlist.dart';
import '../../../domain/usecases/remove_from_wishlist.dart';
import '../../../domain/usecases/add_to_wishlist.dart';
import '../../../domain/usecases/toggle_favorite.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required GetWishlistUseCase getWishlist,
    required RemoveFromWishlistUseCase removeFromWishlist,
    required AddToWishlistUseCase addToWishlist,
    required ToggleFavoriteUseCase toggleFavorite,
  })  : _getWishlist = getWishlist,
        _removeFromWishlist = removeFromWishlist,
        _addToWishlist = addToWishlist,
        _toggleFavorite = toggleFavorite,
        super(const WishlistInitial());
  final GetWishlistUseCase _getWishlist;
  final RemoveFromWishlistUseCase _removeFromWishlist;
  final AddToWishlistUseCase _addToWishlist;
  final ToggleFavoriteUseCase _toggleFavorite;

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    final Either<Failure, List<WishlistProductEntity>> res =
        await _getWishlist();
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

  Future<void> add(WishlistProductEntity product) async {
    final Either<Failure, List<WishlistProductEntity>> res =
        await _addToWishlist(product);
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
    final Either<Failure, List<WishlistProductEntity>> res =
        await _removeFromWishlist(productId);
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
    final Either<Failure, List<WishlistProductEntity>> res =
        await _toggleFavorite.call(productId);
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
