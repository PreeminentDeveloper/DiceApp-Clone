import 'package:dice_app/views/home/home_screen.dart';
import 'package:flutter/cupertino.dart';

BuildContext? globalContext;

class Routes {
  static const String home = '/home';

  static Map<String, Widget Function(BuildContext mainContext)> get getRoutes =>
      {
        home: (BuildContext context) {
          globalContext = context;
          return HomeScreen();
        },
      };
}
