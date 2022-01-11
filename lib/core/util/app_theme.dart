// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pallets.dart';

double _baseFontSize = 16;
double _baseFontSizeSmaller = 14;
double _baseFontSizeLarger = 18;
String fontFamily = 'GTWalsheimPro';

// ------------------------------
// LIGHT THEME
// ------------------------------
final _textThemeLight = TextStyle(
  color: DColors.black,
  fontSize: _baseFontSize,
  fontFamily: fontFamily,
);

var appThemeLight = ThemeData(
  primarySwatch: Colors.amber,
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: DColors.accentColor,
  ),
  indicatorColor: DColors.primaryColor,
  primaryColor: DColors.primaryColor,
  accentColor: DColors.accentColor,
  backgroundColor: DColors.white,
  hintColor: DColors.hintColorLight,
  brightness: Brightness.light,
  scaffoldBackgroundColor: DColors.white,
  // scaffoldBackgroundColor: DColors.backgroundLight,
  dividerColor: DColors.dividerColor,
  disabledColor: DColors.disabledColor,
  errorColor: Colors.amber.shade800,
  cardColor: DColors.cardColorLight,
  appBarTheme: AppBarTheme(
    color: DColors.backgroundLight,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Color(0xFF000000)),
    textTheme: TextTheme(
      headline6: _textThemeLight.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: DColors.iconTint,
    unselectedLabelStyle: _textThemeLight.copyWith(fontSize: _baseFontSize),
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: DColors.black100,
    labelPadding: EdgeInsets.only(bottom: 10),
    indicator: const BoxDecoration(
        border: Border(bottom: BorderSide(color: DColors.black100, width: 2))),
    labelStyle: _textThemeLight.copyWith(
      fontSize: _baseFontSize,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(color: DColors.iconTint),
  primaryTextTheme: TextTheme(
    bodyText1: _textThemeLight,
    bodyText2: _textThemeLight.copyWith(fontSize: _baseFontSizeSmaller),
    headline1: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    headline2: _textThemeLight.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSize),
    caption: _textThemeLight,
    subtitle1: _textThemeLight.copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: DColors.black),
    subtitle2: _textThemeLight.copyWith(
        fontWeight: FontWeight.w400, color: DColors.iconTint),
    button: _textThemeLight,
  ),
);

// ------------------------------
// DARK THEME
// ------------------------------
final _textThemeDark = TextStyle(
  color: DColors.white,
  fontSize: _baseFontSize,
  fontFamily: fontFamily,
);

final appThemeDark = ThemeData(
  primarySwatch: Colors.amber,
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: DColors.accentColor,
  ),
  primaryColor: DColors.primaryColor,
  backgroundColor: DColors.backgroundDark,
  accentColor: DColors.accentColor,
  hintColor: DColors.hintColorDark,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DColors.scaffoldBackgroundDark,
  dividerColor: DColors.dividerColorDark,
  disabledColor: DColors.disabledColor,
  errorColor: Colors.amber.shade400,
  cardColor: DColors.cardDarkGrey,
  appBarTheme: AppBarTheme(
    color: DColors.backgroundDark,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: DColors.white),
    textTheme: TextTheme(
      headline6: _textThemeDark.copyWith(
        fontSize: _baseFontSizeLarger,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  fontFamily: fontFamily,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: DColors.iconTintDark,
    unselectedLabelStyle: _textThemeDark.copyWith(fontSize: _baseFontSize),
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: DColors.white,
    labelPadding: EdgeInsets.only(bottom: 10),
    indicator: const BoxDecoration(
        border: Border(bottom: BorderSide(color: DColors.white, width: 2))),
    labelStyle: _textThemeDark.copyWith(
      fontSize: _baseFontSize,
      fontWeight: FontWeight.bold,
    ),
  ),
  primaryTextTheme: TextTheme(
    bodyText1: _textThemeDark,
    bodyText2: _textThemeDark.copyWith(fontSize: _baseFontSizeSmaller),
    headline1: _textThemeDark.copyWith(
        fontWeight: FontWeight.bold, fontSize: _baseFontSizeLarger),
    caption: _textThemeDark,
    subtitle1: _textThemeDark.copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: DColors.white),
    subtitle2: _textThemeDark.copyWith(
        fontWeight: FontWeight.w400, color: DColors.iconTint),
    button: _textThemeDark,
  ),
);
