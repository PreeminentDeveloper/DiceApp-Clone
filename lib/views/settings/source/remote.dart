import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/settings/model/list_ignore_users_response.dart';
import 'package:dice_app/views/settings/query/dart_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SetUpService {
  final DiceGraphQLClient _graphQLClient;
  SetUpService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<IgnoreUsersResponse> listIgnoreUser(
      {required int pageNumber,
      int perPage = 20,
      required String search,
      required String userID}) async {
    try {
      final _result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(SetUpGql.listIgnoredUsers),
            variables: {
              "pageNo": pageNumber,
              "perPage": perPage,
              "search": search,
              "userId": userID
            },
            fetchPolicy: FetchPolicy.networkOnly),
      );
      return IgnoreUsersResponse.fromJson(_result.data!);
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }

  Future<IgnoreUsersResponse> blockIgnoreUser(
      {required int pageNumber,
      int perPage = 20,
      required String search,
      required String userID}) async {
    try {
      final _result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(SetUpGql.listIgnoredUsers),
            variables: {
              "pageNo": pageNumber,
              "perPage": perPage,
              "search": search,
              "userId": userID
            },
            fetchPolicy: FetchPolicy.networkOnly),
      );
      return IgnoreUsersResponse.fromJson(_result.data!);
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }
}
