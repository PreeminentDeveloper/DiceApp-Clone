import 'package:flutter/cupertino.dart';

BuildContext? globalContext;

class Routes {
  static const String introOne = '/intro_one';
  static const String introTwo = '/intro_two';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String checkEmail = '/checkEmail';
  static const String newPassword = '/newPassword';
  static const String dashboard = '/dashboard';
  static const String successOrder = '/successOrder';
  static const String profileScreen = '/profileScreen';
  static const String sendFundDetails = '/sendFundDetails';
  static const String storeDetailsScreen = '/StoreDetailsScreen';
  static const String signup = '/signup';
  static const String welcome = '/welcome';

  static Map<String, Widget Function(BuildContext mainContext)> get getRoutes =>
      {
        dashboard: (BuildContext context) {
          globalContext = context;
          return Container();
        },
      };
}
