part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {

  const ProfileLoaded(this.profile);
  final ProfileEntity profile;

  @override
  List<Object> get props => [profile];
}

class ProfileUpdating extends ProfileState {

  const ProfileUpdating(this.profile, {required this.isSaving});
  final ProfileEntity profile;
  final bool isSaving;

  @override
  List<Object> get props => [profile, isSaving];
}

class ProfileAvatarUploading extends ProfileState {

  const ProfileAvatarUploading({this.isUploading = false});
  final bool isUploading;

  @override
  List<Object> get props => [isUploading];
}

class ProfileActionLoading extends ProfileState {}

class ProfileError extends ProfileState {

  const ProfileError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class ProfileActionSuccess extends ProfileState {

  const ProfileActionSuccess(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}