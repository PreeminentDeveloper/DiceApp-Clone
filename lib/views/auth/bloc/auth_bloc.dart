import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dice_app/views/auth/data/model/login/login_model.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_model.dart';
import 'package:dice_app/views/auth/data/source/authorization.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // login event
    if (event is StartLoginEvent) {
      try {
        yield AuthLoadingState();
        final response = await _authService.login(event.loginModel);
        yield AuthSuccessState(response: response);
      } catch (e) {
        yield AuthFailedState(message: e.toString());
      }
    }

    /// Verify otp event
    if (event is VerifyOtpEvent) {
      try {
        yield AuthLoadingState();
        final response = await _authService.verifyOtp(event.otpModel);
        yield AuthSuccessState(response: response);
      } catch (e) {
        yield AuthFailedState(message: e.toString());
      }
    }
  }
}
