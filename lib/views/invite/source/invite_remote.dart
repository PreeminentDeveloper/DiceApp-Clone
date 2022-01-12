import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/network/dice_graphQL_client.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/auth/data/model/profile/get_user_data_response.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/invite/model/contacts_exists_response.dart';
import 'package:dice_app/views/invite/model/contacts_model.dart';
import 'package:dice_app/views/profile/model/update_profile_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

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
}
