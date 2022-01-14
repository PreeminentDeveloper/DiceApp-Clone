import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: defaultAppBar(context, title: 'Privacy'),
        body: ListView(children: [
          GreyContainer(title: "Who Can Contact You"),
          _item("Everyone", everyone, first),
          SizedBox(height: SizeConfig.sizeXXL),
          GreyContainer(title: "Private Account"),
          _item("Make Account Private", private, second),
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

  Widget _item(text, bool val, String pos) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: text,
            size: FontSize.s16,
            weight: FontWeight.w500,
            appcolor: DColors.mildDark,
            type: "Objectivity",
          ),
          Spacer(),
          FlutterSwitch(
            // showOnOff: true,
            width: 55,
            height: 30,
            padding: 2,
            value: val,
            inactiveColor: Color(0xffb3b3b3),
            activeColor: DColors.bgGrey,
            toggleColor: DColors.primaryColor,
            inactiveToggleColor: Color(0xff666666),
            switchBorder: Border.all(color: DColors.faded),
            // inactiveSwitchBorder: Border.all(color: DColors.outputColor),
            onToggle: (val) {
              setState(() {
                pos == first ? everyone = val : private = val;
              });
            },
          )
        ],
      ),
    );
  }
}
