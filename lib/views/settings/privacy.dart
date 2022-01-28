import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'widget/settings_toggle.dart';

class Privacy extends StatefulWidget {
  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool everyone = false;

  bool private = false;

  String first = "0";
  String second = "1";

  @override
  void initState() {
    _retrievevalues();
    super.initState();
  }

  void _retrievevalues() {
    everyone = SessionManager.instance.whoCanContactMe;
    private = SessionManager.instance.makeAccountPrivate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: defaultAppBar(context, title: 'Privacy'),
        body: ListView(children: [
          GreyContainer(title: "Who Can Contact You"),
          StatusToggle(
              text: "Everyone",
              boolVal: everyone,
              onToggle: (value) {
                setState(() {
                  everyone = value;
                  SessionManager.instance.whoCanContactMe = value;
                });
              }),
          SizedBox(height: SizeConfig.sizeXXL),
          GreyContainer(title: "Private Account"),
          StatusToggle(
              text: "Make Account Private",
              boolVal: private,
              onToggle: (value) {
                setState(() {
                  private = value;
                  SessionManager.instance.makeAccountPrivate = value;
                });
              }),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextWidget(
              text:
                  "When you make your account private, friends and Dice users won’t be able to view your chats. You also won’t be allowed to view other users chats. ",
              size: FontSize.s12,
              appcolor: DColors.lightGrey,
              height: 1.2,
              type: "Objectivity",
            ),
          ),
        ]));
  }
}
