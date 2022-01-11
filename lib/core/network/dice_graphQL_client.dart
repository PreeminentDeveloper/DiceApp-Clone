import 'package:dice_app/core/data/session_manager.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DiceGraphQLClient {
  GraphQLClient? _client;
  HttpLink? _httpLink;

  DiceGraphQLClient({String? baseUrl, String? authToken}) {
    _httpLink = HttpLink(baseUrl!);
  }

  GraphQLClient get client => buildClient();

  GraphQLClient buildClient({String token = ''}) {
    Link? link;
    if (token.isNotEmpty) {
      AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer ' + SessionManager.instance.authToken,
      );
      link = authLink.concat(_httpLink!);
    }
    _client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link ?? _httpLink!,
    );
    return _client!;
  }

  void setToken({String? token}) {
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ' + SessionManager.instance.authToken,
    );
    final Link link = authLink.concat(_httpLink!);
    _client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }
}
