import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/sign_up.dart';

class SignInSplashScreen extends StatelessWidget {
  const SignInSplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 34.4.h, horizontal: 47.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () => PageRouter.gotoWidget(SignUp(), context),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(2),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(DColors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.sizeXXL!),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 5.h),
                        child: TextWidget(
                          text: "Sign in with Phone",
                          appcolor: DColors.primaryAccentColor,
                          size: FontSize.s18,
                          weight: FontWeight.w600,
                        ),
                      )),
                  SizedBox(height: 78.4.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'By clicking Sign in and using Dice,\nYou agree to our ',
                        style: TextStyle(
                            color: DColors.black500,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Terms ',
                              style: TextStyle(
                                  color: DColors.black500,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // navigate to desired screen
                                }),
                          TextSpan(
                              text: 'and',
                              style: TextStyle(
                                  color: DColors.black500,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // navigate to desired screen
                                }),
                          TextSpan(
                              text: ' Privacy Policy.',
                              style: TextStyle(
                                  color: DColors.black500,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // navigate to desired screen
                                }),
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
