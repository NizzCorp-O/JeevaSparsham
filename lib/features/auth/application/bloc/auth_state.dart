part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//LOG IN
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String userId;
  final String role;
  final String message;
  LoginSuccess(this.message, {required this.userId, required this.role});
}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

//Error
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

//LogOut
class AuthUnauthenticated extends AuthState {}
