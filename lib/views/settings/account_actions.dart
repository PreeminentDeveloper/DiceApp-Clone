import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'widget/account_actions/blocked_list.dart';
import 'widget/account_actions/conversations.dart';
import 'widget/account_actions/ignored_list.dart';

class AccountActions extends StatefulWidget {
  const AccountActions({Key? key}) : super(key: key);

  @override
  _AccountActionsState createState() => _AccountActionsState();
}

class _AccountActionsState extends State<AccountActions> {
  HomeProvider? _homeProvider;
  ProfileProvider? _profileProvider;
  SetUpProvider? _setUpProvider;

  var style = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: DColors.primaryAccentColor)),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
      minimumSize: MaterialStateProperty.all(const Size(50.57, 21.17)));

  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _setUpProvider = Provider.of<SetUpProvider>(context, listen: false);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    _profileProvider?.getUsersInformations();
    _setUpProvider?.listIgnoredAndBlockedUsers(
        pageNumber: 1, userID: _profileProvider!.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: defaultAppBar(context, title: 'Account Actions'),
        body: Consumer<SetUpProvider>(builder: (context, provider, child) {
          if (provider.setUpEnum == SetUpEnum.busy) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              GreyContainer(title: "Chats and Caches"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    TextWidget(
                      text: "Cache",
                      weight: FontWeight.w500,
                      appcolor: const Color(0xff333333),
                      size: FontSize.s16,
                      type: "Objectivity",
                    ),
                    SizedBox(width: SizeConfig.sizeXXL),
                    TextWidget(
                      text: "53.56MB",
                      type: "Objectivity",
                      size: FontSize.s14,
                      weight: FontWeight.w700,
                      appcolor: DColors.primaryColor,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        style: style,
                        child: TextWidget(
                          text: "Clear",
                          type: "Objectivity",
                          size: FontSize.s10,
                          weight: FontWeight.w700,
                          appcolor: DColors.primaryAccentColor,
                        ))
                  ],
                ),
              ),
              _convo(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    TextWidget(
                      text: "Ignored Accounts",
                      weight: FontWeight.w500,
                      appcolor: const Color(0xff333333),
                      size: FontSize.s16,
                      type: "Objectivity",
                    ),
                    SizedBox(width: SizeConfig.sizeXXL),
                    TextWidget(
                      text: provider.ignoreList?.length.toString(),
                      type: "Objectivity",
                      size: FontSize.s14,
                      weight: FontWeight.w700,
                      appcolor: Colors.red,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const IgnoredList()));
                        },
                        style: style,
                        child: TextWidget(
                          text: "view",
                          type: "Objectivity",
                          size: FontSize.s10,
                          weight: FontWeight.w700,
                          appcolor: DColors.primaryAccentColor,
                        ))
                  ],
                ),
              ),
              GreyContainer(title: "Media and Auto-Download"),
            ],
          );
        }));
  }

  _convo() {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            TextWidget(
              text: "Conversations",
              weight: FontWeight.w500,
              appcolor: const Color(0xff333333),
              size: FontSize.s16,
              type: "Objectivity",
            ),
            SizedBox(width: SizeConfig.sizeXXL),
            TextWidget(
              text: (_homeProvider?.list?.length.toString()) ?? "",
              type: "Objectivity",
              size: FontSize.s14,
              weight: FontWeight.w700,
              appcolor: DColors.primaryColor,
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Conversation()));
                },
                style: style,
                child: TextWidget(
                  text: "View",
                  type: "Objectivity",
                  size: FontSize.s10,
                  weight: FontWeight.w700,
                  appcolor: DColors.primaryAccentColor,
                ))
          ],
        ),
      ),
      GreyContainer(title: "Block list"),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            TextWidget(
              text: "Blocked",
              weight: FontWeight.w500,
              appcolor: const Color(0xff333333),
              size: FontSize.s16,
              type: "Objectivity",
            ),
            SizedBox(width: SizeConfig.sizeXXL),
            TextWidget(
              text: _setUpProvider?.blockedList?.length.toString(),
              type: "Objectivity",
              size: FontSize.s14,
              weight: FontWeight.w700,
              appcolor: Colors.red,
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const BlockedList()));
                },
                style: style,
                child: TextWidget(
                  text: "View",
                  type: "Objectivity",
                  size: FontSize.s10,
                  weight: FontWeight.w700,
                  appcolor: DColors.primaryAccentColor,
                ))
          ],
        ),
      ),
    ]);
  }
}
