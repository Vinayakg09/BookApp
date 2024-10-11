part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class OnLogin extends AuthEvent {
  final String email;
  OnLogin({required this.email});
}

final class OnOtp extends AuthEvent {
  final String email;
  final String otp;
  OnOtp({required this.email, required this.otp});
}

final class OnLogout extends AuthEvent {}
