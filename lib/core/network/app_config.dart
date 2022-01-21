enum Environment { development, staging, qa, production }

class AppConfig {
  static Environment environment = Environment.staging;
  static const String stagingURL = "https://vota.cp.reimnet.com/api/";
  static const String productionURL = "";

  static final coreBaseUrl =
      environment == Environment.production ? productionURL : stagingURL;
}
