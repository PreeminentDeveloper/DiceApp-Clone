enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;
  static const String staging = "http://35.175.175.194/graphiql";
  static const String live = "";
  static final coreBaseUrl =
      environment == Environment.production ? live : staging;
}
