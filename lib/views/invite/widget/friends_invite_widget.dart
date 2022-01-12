import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsInviteWidget extends StatelessWidget {
  final String? profilePic;
  final String? text;
  final String? buttonText;
  final String? subText;
  final Function()? onTap;

  const FriendsInviteWidget(
      {Key? key,
      this.profilePic = '',
      this.onTap,
      this.text,
      this.subText,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          CircleImageHandler(
            profilePic,
            radius: 20.r,
            showInitialText: profilePic?.isEmpty,
            initials: Helpers.getInitials(text ?? ''),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: text ?? '',
                  size: FontSize.s16,
                  weight: FontWeight.w500,
                  appcolor: DColors.mildDark,
                ),
                SizedBox(height: 3.h),
                TextWidget(
                  text: subText ?? '',
                  size: FontSize.s14,
                  weight: FontWeight.w500,
                  appcolor: DColors.lightGrey,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: style,
            child: TextWidget(
              text: buttonText ?? '',
              type: "Objectivity",
              size: FontSize.s14,
              weight: FontWeight.w700,
              appcolor: DColors.primaryAccentColor,
            ),
          )
        ],
      ),
    );
  }
}
