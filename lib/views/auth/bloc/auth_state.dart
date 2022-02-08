// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  dynamic response;
  AuthSuccessState({required this.response});
}

class AuthSendingOtpSuccess extends AuthState {
  dynamic response;
  AuthSendingOtpSuccess({required this.response});
}

class AuthVerifyUsernameSuccess extends AuthState {
  UsernameResponse response;
  AuthVerifyUsernameSuccess({required this.response});
}

class AuthFailedState extends AuthState {
  String message;
  AuthFailedState({required this.message});
}
