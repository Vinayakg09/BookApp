part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthGetOtp extends AuthState {
  final String email;
  AuthGetOtp({required this.email});
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

final class AuthOldUser extends AuthState {}

final class AuthNewUser extends AuthState {}

final class AuthLogout extends AuthState {}