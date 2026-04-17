import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/update_profile.dart';
import '../../domain/usecases/upload_avatar.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfile,
    required this.updateProfile,
    required this.uploadAvatar,
    required this.changePassword,
    required this.logout,
    required this.deleteAccount,
  }) : super(ProfileInitial());
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;
  final UploadAvatarUseCase uploadAvatar;
  final ChangePasswordUseCase changePassword;
  final LogoutUseCase logout;
  final DeleteAccountUseCase deleteAccount;

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final result = await getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> editProfile(ProfileEntity updatedLocal) async {
    if (state is ProfileLoaded) {
      emit(ProfileUpdating(updatedLocal, isSaving: false));
    }
  }

  Future<void> saveProfile() async {
    if (state is ProfileUpdating) {
      final updatingState = state as ProfileUpdating;
      emit(ProfileUpdating(updatingState.profile, isSaving: true));
      final result = await updateProfile(updatingState.profile);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile)),
      );
    }
  }

  Future<void> pickAndUploadAvatar(File image) async {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileUpdating(current.profile, isSaving: true));
      final result = await uploadAvatar(image);
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
          emit(current);
        },
        (avatarUrl) {
          final updated = ProfileEntity(
            id: current.profile.id,
            name: current.profile.name,
            email: current.profile.email,
            phone: current.profile.phone,
            address: current.profile.address,
            avatarUrl: avatarUrl,
            createdAt: current.profile.createdAt,
          );
          emit(ProfileLoaded(updated));
        },
      );
    }
  }

  Future<void> changePasswordAction(
      String currentPass, String newPassword) async {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileUpdating(current.profile, isSaving: true));
      final result = await changePassword(currentPass, newPassword);
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
          emit(current);
        },
        (_) {
          emit(const ProfileActionSuccess('Password changed successfully'));
          emit(current);
        },
      );
    }
  }

  Future<void> logoutAction() async {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileUpdating(current.profile, isSaving: true));
      final result = await logout();
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
          emit(current);
        },
        (_) {
          emit(const ProfileActionSuccess('Logged out'));
          emit(current);
        },
      );
    }
  }

  Future<void> deleteAccountAction() async {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      emit(ProfileUpdating(current.profile, isSaving: true));
      final result = await deleteAccount();
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
          emit(current);
        },
        (_) {
          emit(const ProfileActionSuccess('Account deleted'));
          emit(current);
        },
      );
    }
  }
}
