import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageRouter {
  static Future gotoWidget(
    Widget screen,
    BuildContext? context, {
    bool clearStack = false,
    bool fullScreenDialog = false,
    PageTransitionType animationType = PageTransitionType.rightToLeft,
  }) =>
      !clearStack
          ? Navigator.of(context!).push(
              PageTransition(
                type: animationType,
                child: screen,
              ),
            )
          : Navigator.of(context!).pushAndRemoveUntil(
              PageTransition(
                type: animationType,
                child: screen,
              ),
              (_) => false,
            );

  static Future gotoNamed(String route, BuildContext context,
          {bool clearStack = false, dynamic args = Object}) =>
      !clearStack
          ? Navigator.of(context).pushNamed(route, arguments: args)
          : Navigator.of(context)
              .pushNamedAndRemoveUntil(route, (_) => false, arguments: args);

  static void goBack(BuildContext context, {bool rootNavigator = false}) {
    Navigator.of(context, rootNavigator: rootNavigator).pop();
  }

  static void goToRoot(BuildContext context, {String routeName = ''}) =>
      routeName.isNotEmpty ? Navigator.of(context)
          .popUntil(ModalRoute.withName(routeName)) : Navigator.of(context).popUntil((route) => route.isFirst);

}
