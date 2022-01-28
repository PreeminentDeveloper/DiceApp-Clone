import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/settings/widget/settings_toggle.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ChatSettings extends StatefulWidget {
  @override
  _ChatSettingsState createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  bool onlineStatus = false;

  bool receiptMark = false;

  bool pushNotification = false;

  String first = "0";
  String second = "1";
  String third = "3";

  @override
  void initState() {
    _retrievevalues();
    super.initState();
  }

  void _retrievevalues() {
    onlineStatus = SessionManager.instance.showOnlineStatus;
    receiptMark = SessionManager.instance.showReceipt;
    pushNotification = SessionManager.instance.pushNotification;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: defaultAppBar(context, title: 'Chat Settings'),
        body: ListView(children: [
          GreyContainer(title: "Chat Settings"),
          SizedBox(height: 10.h),
          StatusToggle(
              text: "Show Receipt Mark",
              boolVal: receiptMark,
              onToggle: (value) {
                setState(() {
                  receiptMark = value;
                  SessionManager.instance.showReceipt = value;
                });
              }),
          CustomeDivider(),
          StatusToggle(
              text: "Online Status",
              boolVal: onlineStatus,
              onToggle: (value) {
                setState(() {
                  onlineStatus = value;
                  SessionManager.instance.showOnlineStatus = value;
                });
              }),
          CustomeDivider(),
          StatusToggle(
              text: "Push Notification",
              boolVal: pushNotification,
              onToggle: (value) {
                setState(() {
                  pushNotification = value;
                  SessionManager.instance.pushNotification = value;
                });
              }),
          // CustomeDivider(),
          // _item("Push Notification", pushNotification, third),
          // SizedBox(height: 10.h),
          // GreyContainer(title: "Choose a Theme"),
          // SizedBox(height: 10.h),
          // _itemThemes("Default", "assets/okay.svg"),
          // CustomeDivider(),
          // _itemThemes("Greenie", "assets/paint-bucket.svg"),
          // CustomeDivider(),
          // _itemThemes("Torquiest", "assets/paint-bucket.svg"),
          // SizedBox(height: SizeConfig.sizeXL),
          // GreyContainer(title: "Live Wallpaper"),
        ]));
  }

  Widget _itemThemes(text, icon) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.appPadding!, vertical: 3),
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
          SvgPicture.asset(
            icon,
            height: 20,
          )
        ],
      ),
    );
  }
}
