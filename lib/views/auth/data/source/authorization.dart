import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/login/login_model.dart';
import 'package:dice_app/views/auth/data/model/login/login_response.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_model.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_response.dart';
import 'package:dice_app/views/auth/data/model/profile/get_user_data_response.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_response.dart';
import 'package:dice_app/views/auth/data/model/username/username_model.dart';
import 'package:dice_app/views/auth/data/model/username/username_response.dart';

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

  Future<OtpResponse> verifyOtp(OtpModel model) async {
    try {
      final result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(model.verifyOtp()), onError: (data) => logger.e(data)));
      final _otpResponse = OtpResponse.fromJson(result.data!);
      SessionManager.instance.usersData =
          _otpResponse.verifyOtp?.authSession?.user?.toJson()
              as Map<String, dynamic>;
      SessionManager.instance.authToken =
          _otpResponse.verifyOtp?.authSession?.token;
      SessionManager.instance.authLogging = true;
      
      return OtpResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<UsernameResponse> verifyUsername(CodeNameModel model) async {
    try {
      final result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(model.codeNameExists),
            variables: {"codeName": model.codeName}),
      );
      return UsernameResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<ProfileSetUpResponse> setUpProfile(ProfileSetupModel model) async {
    try {
      final result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(model.completeRegistration()),
          onError: (data) => logger.e(data)));

      final _user = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(model.getProfile),
            variables: {"id": model.id},
            fetchPolicy: FetchPolicy.cacheAndNetwork),
      );

      final _data = GetUserDataResponse.fromJson(_user.data!);

      SessionManager.instance.usersData =
          _data.getProfile?.toJson() as Map<String, dynamic>;

      return ProfileSetUpResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
