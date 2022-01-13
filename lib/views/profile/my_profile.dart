import 'dart:io';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/invite/invite-contacts.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/profile/widget/about_modal.dart';
import 'package:dice_app/views/profile/widget/image_modal.dart';
import 'package:dice_app/views/widgets/bottom_sheet.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'modal/bottom_sheet_modal.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _image;
  bool _loading = false;
  ProfileProvider? _profileProvider;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.scaffoldLightBackgroundDark,
        appBar: defaultAppBar(context, title: 'Profile', actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            child: const ImageLoader(
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
                                  // _bottomSheetMore(context, "chat");
                                },
                                child: _items("assets/chat.svg", "Chat"),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // _bottomSheetMore(context, "friend");
                                  },
                                  child: _items(
                                      "assets/add-friend.svg", "Add Friends")),
                              GestureDetector(
                                  onTap: () {
                                    // _bottomSheetMore(context, "trophy");
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
