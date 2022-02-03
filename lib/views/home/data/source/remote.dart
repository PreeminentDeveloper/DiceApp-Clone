import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/model/list_of_conversation_response.dart';
import 'package:dice_app/views/home/data/query/data_query.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class HomeService {
  final DiceGraphQLClient _graphQLClient;
  HomeService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<ListOfConversationResponse> listConvo(
      {required int pageNumber,
      int perPage = 20,
      required String search,
      required String userID}) async {
    try {
      final _result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(HomeGqlMutation.listConversations),
            variables: {
              "pageNo": pageNumber,
              "perPage": perPage,
              "search": search,
              "userId": userID
            },
            fetchPolicy: FetchPolicy.networkOnly),
      );
      return ListOfConversationResponse.fromJson(_result.data);
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }
}
