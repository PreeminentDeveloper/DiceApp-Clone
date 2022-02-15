import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TextersInfoWidget extends StatelessWidget {
  final Animation<Offset> animation;
  final bool animateValue;
  final User? myFriendProfile;
  final User? myFriendFriendsProfile;
  const TextersInfoWidget(this.animateValue, this.animation,
      {Key? key,
      required this.myFriendProfile,
      required this.myFriendFriendsProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Align(
        alignment: Alignment.topLeft,
        child: SlideTransition(
          position: animation,
          transformHitTests: true,
          textDirection: TextDirection.ltr,
          child: AnimatedOpacity(
            opacity: animateValue ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23.r),
                    bottomRight: Radius.circular(23.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: '${myFriendProfile?.username ?? ''}\'s chat',
                      appcolor: DColors.faded,
                      size: FontSize.s15,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomeDivider(),
                    _widget(context, myFriendProfile,
                        onTap: () => PageRouter.gotoWidget(
                            OtherProfile(myFriendProfile!.id!), context)),
                    SizedBox(height: 10.h),
                    _widget(context, myFriendFriendsProfile,
                        onTap: () => PageRouter.gotoWidget(
                            OtherProfile(myFriendFriendsProfile!.id!),
                            context)),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _widget(BuildContext context, User? f, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 16.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleImageHandler('https://${f?.photo?.hostname}/${f?.photo?.url}',
                radius: 15.r),
            SizedBox(width: 15.w),
            SizedBox(
              width: SizeConfig.getDeviceWidth(context) * .4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: f?.name ?? '',
                        appcolor: DColors.mildDark,
                        size: FontSize.s15,
                        weight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 8.w),
                      TextWidget(
                          text: '@${f?.username ?? ''}',
                          appcolor: DColors.faded,
                          size: FontSize.s14,
                          weight: FontWeight.w400)
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                          radius: 5.r,
                          backgroundColor: DColors.primaryAccentColor),
                      // CircleAvatar(
                      //     radius: 5.r,
                      //     backgroundColor: member
                      //             .onlineStatus
                      //         ? DColors.primaryAccentColor
                      //         : DColors.sheetColor),
                      SizedBox(width: 4.w),
                      TextWidget(
                        text: "Online",
                        // member.lastSeen ?? '',
                        appcolor:
                            // member.onlineStatus
                            DColors.primaryAccentColor,
                        // : DColors.sheetColor,
                        size: FontSize.s11,
                        weight: FontWeight.normal,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
