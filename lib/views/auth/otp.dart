import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_model.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';

import 'bloc/auth_bloc.dart';
import 'connect_friends.dart';

class OTP extends StatefulWidget {
  final String? phone, deviceID;

  OTP(this.phone, this.deviceID);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool _loadingState = false;
  final _bloc = AuthBloc(inject());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is AuthLoadingState) {
                setState(() => _loadingState = true);
              }
              if (state is AuthSuccessState) {
                setState(() => _loadingState = false);
                if (state.response?.verifyOtp?.authSession?.user?.status ==
                    "onboarding") {
                  // Todo:=> Proceed
                  // PageRouter.gotoWidget(Birthday(), context);
                } else {
                  PageRouter.gotoWidget(ConnectFriends(), context,
                      clearStack: true);
                }
              }
              if (state is AuthFailedState) {
                setState(() => _loadingState = false);
                // Todo:=> show user error here
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 56.5.h),
                  BackArrow(),
                  SizedBox(height: 46.7.h),
                  TextWidget(
                    text: "Phone Verification \nenter your OTP below",
                    align: TextAlign.center,
                    type: "Objectivity",
                    weight: FontWeight.w700,
                    appcolor: DColors.grey,
                    height: 1.2,
                    size: FontSize.s19,
                  ),
                  SizedBox(height: 149.5.h),
                  TextWidget(
                      text: "6-Digit code",
                      align: TextAlign.center,
                      size: FontSize.s14,
                      type: "Objectivity",
                      weight: FontWeight.w200,
                      appcolor: DColors.faded),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL!),
                    child: PinCodeTextField(
                      appContext: context,
                      // selectedColor: kgreen,
                      // inactiveColor: kAsh,
                      backgroundColor: Colors.transparent,
                      keyboardType: TextInputType.number,
                      length: 6,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: DColors.primaryAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      pinTheme: PinTheme(
                          activeFillColor: DColors.inputText,
                          inactiveColor: DColors.inputText),
                      onCompleted: (value) {
                        _bloc.add(VerifyOtpEvent(
                            otpModel: OtpModel(
                                widget.phone, widget.deviceID, value)));
                      },
                      onChanged: (value) {},
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Didn\'t receive a code?',
                          style: TextStyle(
                              color: DColors.faded,
                              fontFamily: "Objectivity",
                              fontSize: FontSize.s12),
                          children: <TextSpan>[
                        TextSpan(
                            text: ' Resend',
                            style: TextStyle(
                                color: DColors.primaryColor,
                                fontFamily: "Objectivity",
                                fontSize: FontSize.s12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // navigate to desired screen
                              })
                      ])),
                ],
              ),
            ),
          ),
        ));
  }
}
