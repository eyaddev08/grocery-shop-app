part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded(this.items);
  final List<WishlistProductEntity> items;
  @override
  List<Object?> get props => [items];
}

class WishlistEmpty extends WishlistState {
  const WishlistEmpty();
}

class WishlistFailure extends WishlistState {
  const WishlistFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
