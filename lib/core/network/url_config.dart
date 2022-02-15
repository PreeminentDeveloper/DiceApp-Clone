// ignore_for_file: unnecessary_brace_in_string_interps

enum Environment { development, staging, qa, production, bossImo }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String mrImo = "http://10.10.0.124:4020/";
  static const String staging = "http://35.175.175.194/";
  static const String live = "";
  static const String _graphql = "graphiql";
  static const String _upload = "upload";
  static const String _messages = "messages";
  static const String phonixSocketBaseURL =
      "ws://dice-api.reimnet.com/socket/websocket?token=Bearer ";

  static final coreBaseUrl = _url(environment);

  static final uploadBaseUrl = environment == Environment.production
      ? '$live$_upload'
      : '$staging$_upload';

  static final imageUpload = environment == Environment.production
      ? '$live$_messages'
      : '$staging$_messages';

  static String? _url(Environment e) {
    switch (e) {
      case Environment.production:
        return '$live$_graphql';
      case Environment.bossImo:
        return '$mrImo$_graphql';
      case Environment.staging:
        return '$staging$_graphql';
      default:
        return '';
    }
  }
}
