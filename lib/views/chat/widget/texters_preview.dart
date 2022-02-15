import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TextersImagePreview extends StatelessWidget {
  final User? myFriendProfile;
  final User? myFriendFriendsProfile;
  const TextersImagePreview(
      {Key? key,
      required this.myFriendProfile,
      required this.myFriendFriendsProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider, HomeProvider>(
        builder: (context, provider, homeProvider, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: EdgeInsets.only(right: 40.w),
                child: Stack(
                  children: [
                    CircleImageHandler(
                      'https://${myFriendProfile?.photo?.hostname}/${myFriendProfile?.photo?.url}',
                      initials:
                          Helpers.getInitials(myFriendProfile?.name ?? ''),
                      showInitialText:
                          myFriendProfile?.photo?.url?.isEmpty ?? false,
                      borderWidth: 5,
                      radius: 25.r,
                    ),
                    Positioned(
                      top: 35,
                      right: 35,
                      child: CircleAvatar(
                        radius: 8.r,
                        backgroundColor: DColors.white,
                        child: CircleAvatar(
                            radius: 5.r,
                            backgroundColor: DColors.primaryAccentColor),
                      ),
                    ),
                  ],
                ),
              ),

              ///===============================
              ///
              Container(
                margin: EdgeInsets.only(left: 40.w),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        CircleImageHandler(
                          'https://${myFriendFriendsProfile?.photo?.hostname}/${myFriendFriendsProfile?.photo?.url}',
                          initials: Helpers.getInitials(
                              myFriendFriendsProfile?.name ?? ''),
                          showInitialText:
                              myFriendFriendsProfile?.photo?.url?.isEmpty ??
                                  false,
                          borderWidth: 5,
                          radius: 25.r,
                        ),
                        Positioned(
                          top: 35,
                          left: 35,
                          child: CircleAvatar(
                            radius: 8.r,
                            backgroundColor: DColors.white,
                            child: CircleAvatar(
                                radius: 5.r, backgroundColor: DColors.amber),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          TextWidget(
              text:
                  '${myFriendProfile?.name ?? ''}, ${myFriendFriendsProfile?.name ?? ''}',
              appcolor: DColors.black,
              align: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              size: FontSize.s14)
        ],
      );
    });
  }
}
