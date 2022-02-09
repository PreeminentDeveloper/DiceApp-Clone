import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:device_info/device_info.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dice_app/views/widgets/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ChangeNumber extends StatefulWidget {
  @override
  _ChangeNumberState createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  bool checker = false;
  String dialCode = "+234";

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
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
      appBar: defaultAppBar(context, title: "Change Number"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(top: SizeConfig.defaultImageHeight!),
              child: TextWidget(
                text: "Follow the steps below to \nswitch your phone number.",
                align: TextAlign.center,
                type: "Objectivity",
                weight: FontWeight.w700,
                height: 1.2,
                appcolor: DColors.grey,
                size: FontSize.s19,
              ),
            ),
            SizedBox(height: SizeConfig.sizeXXXL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXXL!),
              child: Row(
                children: [
                  CountryListPick(
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: false,
                      isShowCode: false,
                      isDownIcon: true,
                      showEnglishName: false,
                    ),
                    initialSelection: '+234',
                    // or
                    // initialSelection: 'US'
                    onChanged: (code) {
                      setState(() {
                        dialCode = code?.dialCode ?? '';
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
                          hintText: "814 6521 490",
                          hintStyle: TextStyle(
                              color: Color(0xFFE3E3E3),
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
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL!),
              child: Divider(
                color: Color(0xFFE5E5E5),
                thickness: 1.0,
              ),
            ),
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(top: SizeConfig.sizeMedium!),
              child: TextWidget(
                text:
                    "Enter the number you will like to use on \nDice, we’ll text you a verification code",
                appcolor: Color(0xFFB2B2B2),
                size: FontSize.s14,
                weight: FontWeight.w700,
                height: 1.2,
                type: "Objectivity",
              ),
            ),
            SizedBox(height: SizeConfig.sizeXXXL),
            Container(
              height: 44,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4),
              child: TextButton(
                  onPressed: () async {
                    // _onLoginButtonPressed();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (phoneKey.currentState!.validate()) {
                      String deviceId = await _getId();

                      final _user =
                          Provider.of<ProfileProvider>(context, listen: false)
                              .user;

                      Provider.of<SetUpProvider>(context, listen: false)
                          .changePhoneRequest(context, _user!.phone!, deviceId,
                              '+234' + _phoneController.text);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: checker
                          ? MaterialStateProperty.all<Color>(
                              DColors.primaryColor)
                          : MaterialStateProperty.all<Color>(Color(0xFFF2F0F0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.sizeXXL!),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  child: TextWidget(
                    text: "CONFIRM",
                    appcolor: checker ? Colors.white : DColors.lightGrey,
                    size: FontSize.s14,
                    weight: FontWeight.w700,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
