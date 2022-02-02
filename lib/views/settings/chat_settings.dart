import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/provider/chat_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/settings/widget/settings_toggle.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class ChatSettings extends StatefulWidget {
  @override
  _ChatSettingsState createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  ProfileProvider? _profileProvider;
  bool _receipt = true;
  bool _status = true;
  bool _notification = true;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _setValues();
    super.initState();
  }

  void _setValues() {
    _receipt = _profileProvider?.chatSettings?.showReceiptMark ?? true;
    _status = _profileProvider?.chatSettings?.onlineStatus ?? true;
    _notification = _profileProvider?.chatSettings?.pushNotification ?? true;
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
              boolVal: _receipt,
              onToggle: (value) {
                _receipt = value;
                _triggerUpdate();
                setState(() {});
              }),
          CustomeDivider(),
          StatusToggle(
              text: "Online Status",
              boolVal: _status,
              onToggle: (value) {
                _status = value;
                _triggerUpdate();
                setState(() {});
              }),
          CustomeDivider(),
          StatusToggle(
              text: "Push Notification",
              boolVal: _notification,
              onToggle: (value) {
                _notification = value;
                _triggerUpdate();
                setState(() {});
              }),
        ]));
  }

  void _triggerUpdate() {
    _profileProvider?.usersChatSettings(
        receiptMark: _receipt,
        onlineStatus: _status,
        pushNotification: _notification,
        everyone: _profileProvider?.privacySettings?.everyone ?? true,
        privateAccount:
            _profileProvider?.privacySettings?.privateAccount ?? true,
        visibility: _profileProvider?.notificationSettings?.visibility ?? true);
  }
}
