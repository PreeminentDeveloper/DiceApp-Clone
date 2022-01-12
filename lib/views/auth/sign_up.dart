import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:device_info/device_info.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/otp.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
import 'package:dice_app/views/widgets/custom_country_picker.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dice_app/views/widgets/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/auth_bloc.dart';
import 'data/model/login/login_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  bool checker = false;
  bool _loadingState = false;
  String dialCode = "+234";
  final _bloc = AuthBloc(inject());
  String? _deviceID;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is AuthLoadingState) {
              setState(() => _loadingState = true);
            }
            if (state is AuthSuccessState) {
              setState(() => _loadingState = false);
              PageRouter.gotoWidget(
                  OTP(dialCode + _phoneController.text, _deviceID), context);
            }
            if (state is AuthFailedState) {
              logger.d(state.message);
              setState(() => _loadingState = false);
              // Todo:=> show user error here
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 56.5.h),
                      BackArrow(),
                      SizedBox(height: 46.7.h),
                      Container(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text: "Sign in with \nphone number",
                          align: TextAlign.center,
                          type: "Objectivity",
                          weight: FontWeight.w700,
                          height: 1.2,
                          appcolor: DColors.grey,
                          size: FontSize.s19,
                        ),
                      ),
                      SizedBox(height: 181.3.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sizeXXL!),
                        child: Row(
                          children: [
                            CustomCountryListPick(
                              theme: CountryTheme(
                                  isShowFlag: true,
                                  isShowTitle: false,
                                  isShowCode: false,
                                  isDownIcon: true,
                                  showEnglishName: false,
                                  alphabetSelectedBackgroundColor:
                                      DColors.primaryAccentColor),
                              initialSelection: '+234',
                              onChanged: (CountryCode code) {
                                setState(() {
                                  dialCode = code.dialCode!;
                                });
                              },
                            ),
                            Container(
                              width: 1,
                              height: SizeConfig.sizeXXL,
                              color: Colors.grey,
                            ),
                            Flexible(
                              child: Form(
                                key: phoneKey,
                                child: TextFormField(
                                  controller: _phoneController,
                                  validator: validatePhone,
                                  onChanged: (input) {
                                    if (input.trim().isNotEmpty) {
                                      setState(() {
                                        checker = true;
                                      });
                                    } else {
                                      setState(() {
                                        checker = false;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: "814 4920 830",
                                    hintStyle: TextStyle(
                                        color: const Color(0xFFE3E3E3),
                                        fontSize: FontSize.s16,
                                        fontFamily: "Objectivity"),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.sizeXL!),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sizeXXL!),
                        child: const Divider(
                          color: Color(0xFFE5E5E5),
                          thickness: 1.0,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text: "Your number is only used for signing in",
                          appcolor: const Color(0xFFB2B2B2),
                          size: FontSize.s12,
                          weight: FontWeight.w500,
                          type: "Objectivity",
                        ),
                      ),
                      SizedBox(height: 83.3.h),
                      Container(
                        height: 44,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 73.2.w),
                        child: TextButton(
                            onPressed: () async {
                              // _onLoginButtonPressed();
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              if (phoneKey.currentState!.validate()) {
                                _deviceID = await _getId();
                                setState(() {});

                                _bloc.add(StartLoginEvent(
                                    loginModel: LoginModel(
                                        dialCode + _phoneController.text,
                                        _deviceID)));
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: checker
                                    ? MaterialStateProperty.all<Color>(
                                        DColors.primaryColor)
                                    : MaterialStateProperty.all<Color>(
                                        const Color(0xFFF2F0F0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.sizeXXL!),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            child: TextWidget(
                              text: _loadingState ? "LOADING..." : "CONFIRM",
                              appcolor: checker
                                  ? Colors.white
                                  : const Color(0xFFB2B2B2),
                              size: FontSize.s12,
                              weight: FontWeight.w700,
                            )),
                      ),
                      SizedBox(height: 83.3.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
