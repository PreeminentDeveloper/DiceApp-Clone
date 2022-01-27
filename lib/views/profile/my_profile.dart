import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/invite/invite-contacts.dart';
import 'package:dice_app/views/invite/model/connection_request/connection_request_response.dart';
import 'package:dice_app/views/invite/provider/invite_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/profile/widget/about_modal.dart';
import 'package:dice_app/views/profile/widget/bottomsheet_header.dart';
import 'package:dice_app/views/profile/widget/image_modal.dart';
import 'package:dice_app/views/settings/settings.dart';
import 'package:dice_app/views/widgets/bottom_sheet.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'modal/bottom_sheet_modal.dart';
import 'widget/friend_list.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _image;
  bool _loading = false;
  ProfileProvider? _profileProvider;
  InviteProvider? _inviteProvider;
  HomeProvider? _homeProvider;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _inviteProvider = Provider.of<InviteProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getMyConnectionRequest();
  }

  getMyConnectionRequest() {
    _inviteProvider?.getMyConnectionRequest(
        homeProvider: _homeProvider,
        pageNumber: 1,
        id: _profileProvider?.user?.id);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.scaffoldLightBackgroundDark,
        appBar: defaultAppBar(context, title: 'Profile', actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            child: ImageLoader(
              onTap: () => PageRouter.gotoWidget(Settings(), context)
                  .whenComplete(() => setState(() {})),
              imageLink: Assets.settings,
            ),
          )
        ]),
        body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return Container(
              margin: EdgeInsets.all(SizeConfig.appPadding!),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.sizeLarge!),
                          child: Column(
                            children: [
                              Visibility(
                                  visible:
                                      provider.profileEnum == ProfileEnum.busy,
                                  child: const LinearProgressIndicator()),
                              SizedBox(height: 16.h),
                              GestureDetector(
                                onTap: () => showSheet(
                                  context,
                                  child: ImageModal(
                                    fileCallBack: (File? file) {
                                      setState(() => _image = file);
                                      PageRouter.goBack(context);
                                      _profileProvider?.uploadFile(file);
                                    },
                                    deletePhoto: () {
                                      PageRouter.goBack(context);
                                      _profileProvider?.deletePhoto();
                                    },
                                  ),
                                ),
                                child: Center(
                                  child: CircleImageHandler(
                                    'https://${provider.user?.photo?.hostname}/${provider.user?.photo?.url}',
                                    imageFile: _image,
                                    radius: 60.r,
                                    showInitialText:
                                        provider.user?.photo?.url?.isEmpty ??
                                            true,
                                    initials: Helpers.getInitials(
                                        provider.user?.name ?? ''),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.sizeXL),
                              RichText(
                                  text: TextSpan(
                                      text: provider.user?.name ?? '',
                                      style: TextStyle(
                                          color: DColors.mildDark,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Objectivity",
                                          fontSize: FontSize.s16),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            ' @${provider.user?.username ?? ''}',
                                        style: TextStyle(
                                            color: DColors.lightGrey,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Objectivity",
                                            fontSize: FontSize.s12),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // navigate to desired screen
                                          })
                                  ])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //about
                    SizedBox(height: 11.6.h),
                    GestureDetector(
                      onTap: () => showModal(context, const AboutModal()),
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  width: 0.2,
                                  color: Color(0XFF707070),
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 43.h,
                                left: 23.w,
                                right: 23.w,
                                bottom: 23.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: provider.user?.bio ?? 'About you...',
                                  appcolor: DColors.mildDark,
                                  type: "Objectivity",
                                  size: FontSize.s12,
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  "assets/edit.svg",
                                  height: 11,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //items
                    SizedBox(height: 11.6.h),

                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 0.2,
                                color: Color(0XFF707070),
                                style: BorderStyle.solid)),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.sizeLarge!),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _bottomSheetMore(context, "chat");
                                },
                                child: _items("assets/chat.svg", "Chat"),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _bottomSheetMore(context, "friend");
                                  },
                                  child: _items(
                                      "assets/add-friend.svg", "Add Friends")),
                              GestureDetector(
                                  onTap: () {
                                    _bottomSheetMore(context, "trophy");
                                  },
                                  child:
                                      _items("assets/trophy.svg", "Trophies"))
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 11.6.h),

                    GestureDetector(
                      onTap: () =>
                          PageRouter.gotoWidget(InviteContacts(), context),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  width: 0.2,
                                  color: Color(0XFF707070),
                                  style: BorderStyle.solid)),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(SizeConfig.sizeMedium!),
                            child: TextWidget(
                              text: "Invite friends on Dice",
                              appcolor: DColors.primaryColor,
                              weight: FontWeight.w700,
                              type: "Objectivity",
                              size: FontSize.s14,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _items(icon, text) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
          color: DColors.primaryColor,
        ),
        SizedBox(height: 10.h),
        TextWidget(
          text: text,
          appcolor: DColors.mildDark,
          weight: FontWeight.w500,
          type: "Objectivity",
          size: FontSize.s10,
        ),
      ],
    );
  }
}

void _bottomSheetMore(context, label) {
  final _listKey = GlobalKey<AnimatedListState>();

  showModalBottomSheet(
    context: context,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    isScrollControlled: true,
    builder: (builder) {
      return Consumer<InviteProvider>(builder: (context, provider, child) {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                padding: EdgeInsets.all(SizeConfig.sizeSmall!),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r))),
                child: ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(height: SizeConfig.sizeSmall),
                    Center(
                      child: Container(
                          width: SizeConfig.getDeviceWidth(context) / 9,
                          child: const Divider(
                            thickness: 2,
                            color: DColors.lightGrey,
                          )),
                    ),
                    SizedBox(height: SizeConfig.sizeSmall),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.sizeLarge!,
                      ),
                      child: label == "chat"
                          ? const BottomSheetHeader(
                              header: "Chat Notifications",
                              icon: "assets/bell.svg")
                          : label == "friend"
                              ? const BottomSheetHeader(
                                  header: "Friends",
                                  icon: "assets/add-friend-colored.svg")
                              : const BottomSheetHeader(
                                  header: "Trophies",
                                  icon: "assets/favourite.svg"),
                    ),
                    SizedBox(height: SizeConfig.sizeSmall),
                    CustomeDivider(),
                    if (label == "friend"
                    // && provider.myRequest != null
                    )
                      AnimatedList(
                          key: _listKey,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          initialItemCount: provider.myRequest.length,
                          itemBuilder: (context, index, animation) {
                            return FriendList(
                              provider.myRequest[index],
                              ignoreUser: () {
                                // provider.myRequest.remove(friends)
                                //
                                provider.notifyListeners();
                              },
                            );
                          })

                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const ScrollPhysics(),
                    //   itemBuilder: (context, item) {
                    //     final ListData? friends =
                    //         provider.myRequest.elementAt(item);
                    //     return AnimatedOpacity(
                    //       opacity:
                    //           _userID == friends!.requester?.id ? 0.0 : 1.0,
                    //       duration: Duration(seconds: 500),
                    //       child: FriendList(
                    //         friends,
                    //         ignoreUser: () {
                    //           _userID = friends.requester?.id;
                    //           // provider.myRequest.remove(friends)
                    //           //
                    //           logger.d(_userID);
                    //           provider.notifyListeners();
                    //         },
                    //       ),
                    //     );
                    //   },
                    //   itemCount: provider.myRequest.length,
                    // )
                  ],
                ),
              );
            });
      });
    },
  );
}
