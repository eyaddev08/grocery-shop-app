// حالات المصادقة
// ملف مسؤول عن إدارة حالة المصادقة باستخدام Cubit.

import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthNeedsVerification extends AuthState {
  final String email;

  const AuthNeedsVerification(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordResetRequested extends AuthState {
  final String email;

  const AuthPasswordResetRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthResetCodeVerified extends AuthState {
  final String email;
  final String token;

  const AuthResetCodeVerified({
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email, token];
}

