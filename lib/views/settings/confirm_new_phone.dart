import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/data/model/otp/otp_model.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class ChangePhoneOtp extends StatefulWidget {
  final String? phone;

  ChangePhoneOtp(this.phone);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<ChangePhoneOtp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                    weight: FontWeight.w700,
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
                    onCompleted: (value) {},
                    onChanged: (value) {
                      if (value.length == 6) {
                        Provider.of<SetUpProvider>(context, listen: false)
                            .changePhoneConfirm(context, value, widget.phone!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
