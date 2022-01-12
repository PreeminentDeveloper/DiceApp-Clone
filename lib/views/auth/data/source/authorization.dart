import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/login/login_model.dart';
import 'package:dice_app/views/auth/data/model/login/login_response.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_model.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_response.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class AuthService {
  final DiceGraphQLClient _graphQLClient;
  AuthService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<LoginResponse> login(LoginModel model) async {
    try {
      final result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(model.beginLogin()),
          onError: (data) => logger.e(data)));
      return LoginResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<dynamic> verifyOtp(OtpModel model) async {
    try {
      final result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(model.verifyOtp()),
          onError: (data) => logger.e(data)));
      final _otpResponse = OtpResponse.fromJson(result.data!);
      SessionManager.instance.usersData = _otpResponse.data?.verifyOtp?.authSession?.user as Map<String, dynamic>;
      SessionManager.instance.authToken = _otpResponse.data?.verifyOtp?.authSession?.token;
      return OtpResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
