import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  /*Padding & Margin Constants*/

  static double? sizeExtraSmall;
  static double? sizeDefault;
  static double? sizeSmall;
  static double? sizeMedium;
  static double? appPadding;
  static double? sizeLarge;
  static double? sizeXL;
  static double? sizeXXL;
  static double? sizeXXXL;

  /*Screen Size dependent Constants*/
  static double? screenWidthHalf;
  static double? screenWidthThird;
  static double? screenWidthFourth;
  static double? screenWidthFifth;
  static double? screenWidthSixth;
  static double? screenWidthTenth;

  /*Image Dimensions*/

  static double? defaultIconSize;
  static double? defaultImageHeight;
  static double? snackBarHeight;
  static double? texIconSize;

  /*Default Height&Width*/
  static double? defaultIndicatorHeight;
  static double? defaultIndicatorWidth;

  /*EdgeInsets*/
  static EdgeInsets? spacingAllDefault;
  static EdgeInsets? spacingAllSmall;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        // context,
        designSize: Size(
          screenWidth!,
          screenHeight!,
        ),
        orientation: Orientation.portrait
        // allowFontScaling: true
        );

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    sizeExtraSmall = ScreenUtil().setWidth(5.0);
    sizeDefault = ScreenUtil().setWidth(8.0);
    sizeSmall = ScreenUtil().setWidth(10.0);
    sizeMedium = ScreenUtil().setWidth(15.0);
    appPadding = ScreenUtil().setWidth(16.0);
    sizeLarge = ScreenUtil().setWidth(20.0);
    sizeXL = ScreenUtil().setWidth(30.0);
    sizeXXL = ScreenUtil().setWidth(40.0);
    sizeXXXL = ScreenUtil().setWidth(50.0);

    /*EdgeInsets*/

    spacingAllDefault = EdgeInsets.all(sizeDefault!);
    spacingAllSmall = EdgeInsets.all(sizeSmall!);

    /*Screen Size dependent Constants*/
    screenWidthHalf = ScreenUtil().screenWidth / 2;
    screenWidthThird = ScreenUtil().screenWidth / 3;
    screenWidthFourth = ScreenUtil().screenWidth / 4;
    screenWidthFifth = ScreenUtil().screenWidth / 5;
    screenWidthSixth = ScreenUtil().screenWidth / 6;
    screenWidthTenth = ScreenUtil().screenWidth / 10;

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil().setWidth(80.0);
    defaultImageHeight = ScreenUtil().setHeight(120.0);
    snackBarHeight = ScreenUtil().setHeight(50.0);
    texIconSize = ScreenUtil().setWidth(30.0);

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil().setHeight(5.0);
    defaultIndicatorWidth = screenWidthFourth;
  }

  /// get devices height
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height.h;
  }

  /// get devices height
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width.w;
  }
}

class FontSize {
  static double? s7;
  static double? s8;
  static double? s9;
  static double? s10;
  static double? s11;
  static double? s12;
  static double? s13;
  static double? s14;
  static double? s15;
  static double? s16;
  static double? s17;
  static double? s18;
  static double? s19;
  static double? s20;
  static double? s21;
  static double? s22;
  static double? s23;
  static double? s24;
  static double? s25;
  static double? s26;
  static double? s27;
  static double? s28;
  static double? s29;
  static double? s30;
  static double? s32;
  static double? s36;
  static double? s40;

  static setScreenAwareFontSize() {
    s7 = ScreenUtil().setSp(7.0);
    s8 = ScreenUtil().setSp(8.0);
    s9 = ScreenUtil().setSp(9.0);
    s10 = ScreenUtil().setSp(10.0);
    s11 = ScreenUtil().setSp(11.0);
    s12 = ScreenUtil().setSp(12.0);
    s13 = ScreenUtil().setSp(13.0);
    s14 = ScreenUtil().setSp(14.0);
    s15 = ScreenUtil().setSp(15.0);
    s16 = ScreenUtil().setSp(16.0);
    s17 = ScreenUtil().setSp(17.0);
    s18 = ScreenUtil().setSp(18.0);
    s19 = ScreenUtil().setSp(19.0);
    s20 = ScreenUtil().setSp(20.0);
    s21 = ScreenUtil().setSp(21.0);
    s22 = ScreenUtil().setSp(22.0);
    s23 = ScreenUtil().setSp(23.0);
    s24 = ScreenUtil().setSp(24.0);
    s25 = ScreenUtil().setSp(25.0);
    s26 = ScreenUtil().setSp(26.0);
    s27 = ScreenUtil().setSp(27.0);
    s28 = ScreenUtil().setSp(28.0);
    s29 = ScreenUtil().setSp(29.0);
    s30 = ScreenUtil().setSp(30.0);
    s32 = ScreenUtil().setSp(32.0);
    s36 = ScreenUtil().setSp(36.0);
    s40 = ScreenUtil().setSp(40.0);
  }
}
