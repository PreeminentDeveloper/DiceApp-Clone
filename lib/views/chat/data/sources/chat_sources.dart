import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/data/models/chat_model.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatService {
  final DiceGraphQLClient _graphQLClient;
  ChatService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<ListOoChatResponse> chatList(
      {int? pageNo = 1,
      int? perPage = 100,
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
