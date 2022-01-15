import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/settings/model/blocked_user_response.dart';
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

  Future<BlockedUsersResponse> listBlockedUser(
      {required int pageNumber,
      int perPage = 20,
      required String search,
      required String userID}) async {
    try {
      final _result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(SetUpGql.listBlockedUsers),
            variables: {
              "pageNo": pageNumber,
              "perPage": perPage,
              "search": search,
              "userId": userID
            },
            fetchPolicy: FetchPolicy.networkOnly),
      );

      return BlockedUsersResponse.fromJson(_result.data!);
    } catch (exception) {
      logger.e(exception);
      rethrow;
    }
  }

  Future<dynamic> unignoreUser({String? userID, String? receiverID}) async {
    try {
      final _result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(
              SetUpGql.unignoreUser(userId: userID, ignoredId: receiverID))));
      logger.d(_result.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<dynamic> unblockUser({String? userID, String? receiverID}) async {
    try {
      final _result = await _graphQLClient.client.mutate(MutationOptions(
          document: gql(
              SetUpGql.unblockUser(userId: userID, blockedId: receiverID))));
      logger.d(_result.data);
    } catch (e) {
      logger.e(e);
    }
  }
}
