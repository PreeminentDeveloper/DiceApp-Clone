// ignore_for_file: unrelated_type_equality_checks

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/message_screen.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widget/friends_background.dart';
import 'widget/friends_chat.dart';
import 'widget/friends_profile_window_widget.dart';
import 'widget/not_a_chatty_user.dart';
import 'widget/note_window.dart';

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
    Provider.of<HomeProvider>(context, listen: false).listConversations(
        pageNumber: 1, search: '', userID: widget.id, saveConvo: false);
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
              if (profile.profileEnum == ProfileEnum.busy) {
                return const Center(child: CircularProgressIndicator());
              }
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
                                      '@${profile.getUserDataResponse?.getProfile?.username ?? ''}',
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
                  _requestButton(profile.getUserDataResponse?.getProfile),
                  TextWidget(
                    text: "Chats",
                    appcolor: DColors.mildDark,
                    weight: FontWeight.w500,
                    type: "Objectivity",
                    size: FontSize.s12,
                  ),
                  SizedBox(height: 16.h),
                  homeProvider.conversationList!.isEmpty
                      ? const NotAChattyUser()
                      : FriendsChat(widget.id,
                          myFriendProfile:
                              profile.getUserDataResponse?.getProfile)
                ],
              );
            },
          )
        ],
      ),
    );
  }

  GestureDetector _requestButton(User? getProfile) {
    return GestureDetector(
      onTap: () {
        if (getProfile?.connection?.toLowerCase() == "unconnected") {
          _makeRequest(getProfile);
        }
      },
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 23.w),
            child: _buttonIconDetector(getProfile),
          ),
        ),
      ),
    );
  }

  /// RETURNS ICONS FOR BUTTON
  Widget? _buttonIconDetector(User? value) {
    switch (value?.connection?.toLowerCase()) {
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
        return GestureDetector(
          onTap: () {
            chatDao!.openABox(value!.conversation!.id!);
            PageRouter.gotoWidget(
                MessageScreen(
                    user: value, conversationID: value.conversation?.id),
                context);
          },
          child: Row(
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
          ),
        );
    }
  }

  void _makeRequest(User? value) {
    if (value?.connection!.toLowerCase() != 'unconnected' &&
        value?.connection!.toLowerCase() != 'requested') {
      return;
    }

    _showDialog();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
              text: 'Add a note (optional)',
              size: FontSize.s17,
              weight: FontWeight.w700,
              appcolor: DColors.lightGrey,
              align: TextAlign.center,
            ),
            content: NoteWindow(
              justFollow: () => _followThisUser(),
              addNote: (String note) => _followThisUser(note: note),
            ),
          );
        });
  }

  _followThisUser({String? note}) {
    _profileProvider?.requestConnection(msg: note, friendsID: widget.id);
    _profileProvider?.getMyFriendsProfile(widget.id);
  }
}
