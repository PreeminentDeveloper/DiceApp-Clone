// ignore_for_file: unnecessary_brace_in_string_interps

enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String staging = "http://35.175.175.194/";
  static const String live = "";
  static const String _graphql = "graphiql";
  static const String _upload = "upload";
  static const String _messages = "messages";
  static const String phonixSocketBaseURL =
      "ws://dice-api.reimnet.com/socket/websocket?token=Bearer ";

  static final coreBaseUrl = environment == Environment.production
      ? '$live$_graphql'
      : '$staging$_graphql';
  static final uploadBaseUrl = environment == Environment.production
      ? '$live$_upload'
      : '$staging$_upload';

  static final imageUpload = environment == Environment.production
      ? '$live$_messages'
      : '$staging$_messages';
}
