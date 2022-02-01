import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/profile/get_user_data_response.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/profile/model/codename_verification.dart';
import 'package:dice_app/views/profile/model/update_profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

final ProfileSetupModel _model = ProfileSetupModel();

class ProfileService {
  final DiceGraphQLClient _graphQLClient;
  ProfileService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<dynamic> profileImageUpdate(File? file) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(UrlConfig.uploadBaseUrl));

      //Header....
      request.headers['Authorization'] =
          'Bearer ${SessionManager.instance.authToken}';

      request.fields['type'] = "profile_picture";
      request.files.add(await http.MultipartFile.fromPath('image', file!.path));
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      return res.body;
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }

  Future<GetUserDataResponse?> getUsersProfile(ProfileSetupModel model,
      {bool isMyProfile = true}) async {
    try {
      final _user = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(model.getProfile),
            variables: {"id": model.id},
            fetchPolicy: FetchPolicy.networkOnly),
      );
      final _data = GetUserDataResponse.fromJson(_user.data);
      if (isMyProfile) {
        SessionManager.instance.usersData =
            _data.getProfile?.toJson() as Map<String, dynamic>;
      }
      return _data;
    } catch (e) {
      logger.e(e);
    }
  }

  Future<UpdateUserDataResponse?> updateUsersInfo(
      String key, String value, String id) async {
    try {
      final _result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(_model.updateUserInfo(key, value, id))));
      final _response = UpdateUserDataResponse.fromJson(_result.data);
      SessionManager.instance.usersData =
          _response.updateUser?.user?.toJson() as Map<String, dynamic>;
      return _response;
    } catch (e) {
      logger.e(e);
    }
  }

  Future<dynamic> requestConnection(
      {String? msg, String? myID, String? friendsID}) async {
    try {
      final _result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(_model.requestConnection(
              message: msg, requesterId: myID, userId: friendsID))));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<dynamic> acceptConnection(
      {String? msg, String? senderID, String? receiverID}) async {
    try {
      await _graphQLClient.client.mutate(MutationOptions(
          document: gql(_model.acceptConnectionRequest(
              message: msg, requesterId: senderID, userId: receiverID))));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<dynamic> ignoreUser({String? userID, String? receiverID}) async {
    try {
      await _graphQLClient.client.mutate(MutationOptions(
          document:
              gql(_model.ignoreUser(userId: userID, ignoredId: receiverID))));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<CodeNameVerification?> verifyUserName(String username) async {
    try {
      final _result = await _graphQLClient.client.mutate(MutationOptions(
        document: gql(_model.codeNameExists),
        variables: {"codeName": username},
      ));
      return CodeNameVerification.fromJson(_result.data!);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deletePhoto() async {
    try {
      final _model = ProfileSetupModel();
      final _user = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(_model.deletePhoto),
            fetchPolicy: FetchPolicy.networkOnly),
      );
      logger.d(_user.data);
    } catch (e) {
      logger.e(e);
    }
  }
}
