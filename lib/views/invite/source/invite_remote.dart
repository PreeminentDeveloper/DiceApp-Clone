import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/invite/model/connection_request/connection_request_response.dart';
import 'package:dice_app/views/invite/model/contact/contacts_exists_response.dart';
import 'package:dice_app/views/invite/model/contact/contacts_model.dart';
import 'package:dice_app/views/invite/model/find_people/search_users_response.dart';
import 'package:dice_app/views/invite/model/my_connections/my_connections_response.dart';
import 'package:dice_app/views/invite/query/data_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InviteService {
  final DiceGraphQLClient _graphQLClient;
  InviteService({required DiceGraphQLClient networkService})
      : _graphQLClient = networkService;

  Future<ContactsExistResponse?> checkIfContactsExists(
      ContactsModel model) async {
    try {
      final _data = await _graphQLClient.client.mutate(
        MutationOptions(
            document:
                gql(model.comparePhoneContactWithDiceContact(model.contacts)),
            onError: (data) => logger.e(data)),
      );
      return ContactsExistResponse.fromJson(_data.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<MyConnectionResponse?> getConnections(
      {required int pageNumber,
      required int perPage,
      required String userID}) async {
    try {
      final result = await _graphQLClient.client.query(
        QueryOptions(
            document: gql(InviteGQL.listConnections),
            variables: {
              "pageNo": pageNumber,
              "perPage": perPage,
              "userId": userID
            },
            fetchPolicy: FetchPolicy.networkOnly),
      );
      return MyConnectionResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<SearchUserResponse?> findPeople({required String name}) async {
    try {
      final result = await _graphQLClient.client.query(QueryOptions(
          document: gql(InviteGQL.searchUser),
          variables: {"search": name},
          fetchPolicy: FetchPolicy.networkOnly));
      return SearchUserResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<ConnectionRequestResponse?> myConnectionRequest(
      {required int pageNumber,
      required int perPage,
      required String userID}) async {
    try {
      final result = await _graphQLClient.client.query(QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(InviteGQL.listConnectionRequest),
          variables: {"pageNo": pageNumber, "perPage": 20, "userId": userID}));

      return ConnectionRequestResponse.fromJson(result.data!);
    } catch (e) {
      logger.e(e);
    }
  }
}
