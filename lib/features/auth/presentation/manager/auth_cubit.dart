// مكعب حالة المصادقة
// ملف مسؤول عن تعريف حالات الكيوبت الخاصة بالمصادقة.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/request_password_reset.dart';
import '../../domain/usecases/verify_reset_code.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/refresh_token.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login loginUseCase;
  final Register registerUseCase;
  final RequestPasswordReset requestPasswordResetUseCase;
  final VerifyResetCode verifyResetCodeUseCase;
  final ResetPassword resetPasswordUseCase;
  final RefreshToken refreshTokenUseCase;
  final AuthRepository repository;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.requestPasswordResetUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
    required this.refreshTokenUseCase,
    required this.repository,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) async {
        // Get user info from token or make a separate call
        // For now, we'll emit authenticated without user
        // TODO: Fetch user profile after login
        emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        // TODO: Optionally auto-login after registration
        emit(AuthNeedsVerification(user.email));
      },
    );
  }

  Future<void> requestPasswordReset(String email) async {
    emit(AuthLoading());
    final result = await requestPasswordResetUseCase(email);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthPasswordResetRequested(email)),
    );
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(AuthLoading());
    final result = await verifyResetCodeUseCase(email, code);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (token) => emit(AuthResetCodeVerified(email: email, token: token)),
    );
  }

  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase(
      token: token,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await repository.logout();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> checkAuthStatus() async {
    final result = await repository.getStoredTokens();
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (token) {
        if (token != null) {
          // TODO: Validate token expiry and fetch user profile
          emit(AuthUnauthenticated());
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }
}
