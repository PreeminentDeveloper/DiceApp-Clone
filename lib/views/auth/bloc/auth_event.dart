// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class StartLoginEvent extends AuthEvent {
  LoginModel loginModel;
  StartLoginEvent({required this.loginModel});
}

class VerifyOtpEvent extends AuthEvent {
  OtpModel otpModel;
  VerifyOtpEvent({required this.otpModel});
}

class VerifyUsernameEvent extends AuthEvent {
  CodeNameModel codeNameModel;
  VerifyUsernameEvent({required this.codeNameModel});
}

class ProfileSetUpEvent extends AuthEvent {
  ProfileSetupModel profileSetupModel;
  ProfileSetUpEvent({required this.profileSetupModel});
}
