import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/data/session_manager.dart';
import 'core/navigation/routes.dart';
import 'core/network/url_config.dart';
import 'core/util/injection_container.dart';
import 'views/onboarding/sign_in_splash.dart';

void main() async {
  await initializeCore(environment: Environment.staging);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return MaterialApp(
          title: 'DiceMessanger',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.green),
          routes: Routes.getRoutes,
          home: SessionManager.instance.authLogging
              ? const SignInSplashScreen()
              : const SignInSplashScreen(),
        );
      },
    );
  }
}
