import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widget/friends_background.dart';
import 'widget/friends_profile_window_widget.dart';
import 'widget/not_a_chatty_user.dart';

class OtherProfile extends StatefulWidget {
  final String id;
  const OtherProfile(this.id);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  ProfileProvider? _profileProvider;
  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _profileProvider?.getMyFriendsProfile(widget.id);
    Provider.of<HomeProvider>(context, listen: false)
        .listConversations(pageNumber: 1, search: '', userID: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.scaffoldLightBackgroundDark,
      body: Stack(
        children: <Widget>[
          const FriendsProfileImageBackground(),
          Consumer2<ProfileProvider, HomeProvider>(
            builder: (context, profile, homeProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileInfoWindowWidget(
                      profile.getUserDataResponse?.getProfile),
                  Container(
                    margin: EdgeInsets.all(SizeConfig.appPadding!),
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextWidget(
                                  text: profile.getUserDataResponse?.getProfile
                                          ?.name ??
                                      '',
                                  appcolor: DColors.mildDark,
                                  weight: FontWeight.w500,
                                  type: "Objectivity",
                                  size: FontSize.s16,
                                ),
                                SizedBox(width: SizeConfig.sizeExtraSmall),
                                TextWidget(
                                  text:
                                      '@ ${profile.getUserDataResponse?.getProfile?.username ?? ''}',
                                  appcolor: DColors.lightGrey,
                                  weight: FontWeight.w500,
                                  type: "Objectivity",
                                  size: FontSize.s12,
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.sizeSmall),
                            TextWidget(
                              text: profile
                                      .getUserDataResponse?.getProfile?.bio ??
                                  '',
                              type: "Objectivity",
                              size: FontSize.s13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _requestButton(
                      profile.getUserDataResponse?.getProfile?.connection ??
                          ''),
                  TextWidget(
                    text: "Chats",
                    appcolor: DColors.mildDark,
                    weight: FontWeight.w500,
                    type: "Objectivity",
                    size: FontSize.s12,
                  ),
                  SizedBox(height: 16.h),
                  homeProvider.list!.isEmpty
                      ? const NotAChattyUser()
                      : const Text('Other things here')
                ],
              );
            },
          )
        ],
      ),
    );
  }

  GestureDetector _requestButton(String status) {
    return GestureDetector(
      onTap: () => _makeRequest(status),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 23.w),
            child: _buttonIconDetector(status),
          ),
        ),
      ),
    );
  }

  /// RETURNS ICONS FOR BUTTON
  Widget? _buttonIconDetector(String value) {
    switch (value.toLowerCase()) {
      case 'unconnected':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: "Follow",
              appcolor: DColors.primaryColor,
              weight: FontWeight.w700,
              type: "Objectivity",
              size: FontSize.s16,
            ),
            SizedBox(width: SizeConfig.sizeExtraSmall),
            SvgPicture.asset(
              "assets/add-friend.svg",
              color: DColors.primaryColor,
            )
          ],
        );
      case 'requested':
        return SvgPicture.asset(
          "assets/ellipsis.svg",
          color: DColors.primaryColor,
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: "Chat",
              appcolor: DColors.primaryColor,
              weight: FontWeight.w700,
              type: "Objectivity",
              size: FontSize.s16,
            ),
            SizedBox(width: SizeConfig.sizeExtraSmall),
            SvgPicture.asset(
              "assets/message.svg",
              color: DColors.primaryColor,
            )
          ],
        );
    }
  }

  void _makeRequest(String value) {
    if (value.toLowerCase() != 'unconnected' &&
        value.toLowerCase() != 'requested') {
      logger.d('Navigate user to chat screen here');
      return;
    }

    logger.d('Request user to be friends with');
  }
}
