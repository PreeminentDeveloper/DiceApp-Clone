import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/sign_up.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'account_actions.dart';
import 'acct_settings/account_settings.dart';
import 'additional_service.dart';
import 'chat_settings.dart';
import 'legal.dart';
import 'privacy.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Settings'),
      backgroundColor: DColors.scaffoldLightBackgroundDark,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(SizeConfig.sizeExtraSmall!),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AccountSetting()));
                },
                child: _card(
                  "assets/user.svg",
                  20.0,
                  "My Account",
                  "Edit User and other Account Info.",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChatSettings()));
                },
                child: _card(
                  "assets/chat-icon.svg",
                  18.0,
                  "Chat Settings",
                  "Chats, Delivery and Notification Settings",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Privacy()));
                },
                child: _card(
                  "assets/privacy.svg",
                  20.0,
                  "Privacy",
                  "Chat views, Permissions and Contact Settings",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AdditionalService()));
                },
                child: _card(
                  "assets/info.svg",
                  18.0,
                  "Additional Services",
                  "Support, Rewards, Filters and Badges, Inviting Friends",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => AccountActions()));
                },
                child: _card(
                  "assets/reload.svg",
                  18.0,
                  "Account Actions",
                  "Chats, Delivery and Notification Settings",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Legal()));
                },
                child: _card(
                  "assets/legal.svg",
                  18.0,
                  "Legal",
                  "Terms of Services and Licences",
                ),
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {
                    // await sharedStore.clean();
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: TextWidget(
                              text:
                                  'Are you sure you want\nto log out of Dice?',
                              size: FontSize.s17,
                              weight: FontWeight.w700,
                              appcolor: DColors.lightGrey,
                              align: TextAlign.center,
                            ),
                            content: Container(
                              height: 250,
                              child: Column(
                                children: [
                                  SizedBox(height: 23.h),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: SizeConfig.sizeExtraSmall!),
                                      child: SvgPicture.asset("assets/go.svg")),
                                  SizedBox(height: 23.h),
                                  Container(
                                    height: 35,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        vertical: SizeConfig.sizeMedium!),
                                    child: TextButton(
                                        onPressed: () async {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignUp()),
                                              (Route<dynamic> route) => false);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            SizeConfig
                                                                .sizeXXL!),
                                                    side: BorderSide(
                                                        color: Colors.red)))),
                                        child: TextWidget(
                                          text: "Logout",
                                          appcolor: DColors.white,
                                          size: FontSize.s14,
                                          weight: FontWeight.w700,
                                        )),
                                  ),
                                  Container(
                                    height: 35,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                8),
                                    child: TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            // backgroundColor: checker ? MaterialStateProperty.all<Color>( DColors.primaryColor)
                                            //     : MaterialStateProperty.all<Color>(Color(0xFFF2F0F0)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            SizeConfig
                                                                .sizeXXL!),
                                                    side: BorderSide(
                                                        color: DColors
                                                            .lightGrey)))),
                                        child: TextWidget(
                                          text: "Cancel",
                                          appcolor: DColors.lightGrey,
                                          size: FontSize.s14,
                                          weight: FontWeight.w700,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            actions: [],
                          );
                        });
                  },
                  child: Card(
                    margin: EdgeInsets.all(SizeConfig.sizeSmall!),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                      child: TextWidget(
                        text: "Logout",
                        appcolor: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(icon, size, title, body) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(SizeConfig.sizeSmall!),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: size,
              color: DColors.black,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    weight: FontWeight.w500,
                    size: FontSize.s16,
                  ),
                  SizedBox(height: 5),
                  TextWidget(
                    text: body,
                    size: FontSize.s10,
                    weight: FontWeight.w500,
                    type: 'Objectivity',
                    appcolor: DColors.lightGrey,
                  )
                ],
              ),
            ),
            // Spacer(),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
