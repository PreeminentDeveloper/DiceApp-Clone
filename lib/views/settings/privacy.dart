import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'widget/settings_toggle.dart';

class Privacy extends StatefulWidget {
  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  ProfileProvider? _profileProvider;
  bool _everyone = true;
  bool _private = true;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _setValues();
    super.initState();
  }

  void _setValues() {
    _everyone = _profileProvider?.privacySettings?.everyone ?? true;
    _private = _profileProvider?.privacySettings?.privateAccount ?? true;
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
              boolVal: _everyone,
              onToggle: (value) {
                _everyone = value;
                _triggerUpdate();
                setState(() {});
              }),
          SizedBox(height: SizeConfig.sizeXXL),
          GreyContainer(title: "Private Account"),
          StatusToggle(
              text: "Make Account Private",
              boolVal: _private,
              onToggle: (value) {
                _private = value;
                _triggerUpdate();
                setState(() {});
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

  void _triggerUpdate() {
    _profileProvider?.usersChatSettings(
        receiptMark: _profileProvider?.chatSettings?.showReceiptMark,
        onlineStatus: _profileProvider?.chatSettings?.onlineStatus,
        pushNotification:
            _profileProvider?.chatSettings?.pushNotification ?? true,
        everyone: _everyone,
        privateAccount: _private,
        visibility: _profileProvider?.notificationSettings?.visibility ?? true);
  }
}
