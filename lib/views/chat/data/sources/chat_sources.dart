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
import 'package:dice_app/views/chat/data/models/chat_model.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:dice_app/views/home/data/model/list_of_conversation_response.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class ChatService {
  final DiceGraphQLClient _graphQLClient;
  ChatService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<ListOoChatResponse> chatList(
      {int? pageNo = 1,
      int? perPage = 20,
      String? userID,
      String? conversationID}) async {
    try {
      final result = await _graphQLClient.client.query(QueryOptions(
          document: gql(ChatModel.listMessages),
          fetchPolicy: FetchPolicy.networkOnly,
          variables: {
            "pageNo": pageNo,
            "perPage": perPage,
            "userId": userID,
            "conversationId": conversationID
          }));
      return ListOoChatResponse.fromJson(result.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<dynamic> deleteMessage(int msgId, String userId) async {
    try {
      final _response = await _graphQLClient.client.query(QueryOptions(
          document: gql(ChatModel.deleteMessage(msgId, userId)),
          fetchPolicy: FetchPolicy.networkOnly));
      logger.d(_response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
