import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class ChatObject {
  final String? image;
  final String? name;
  final String? recentMessage;
  final String? date;

  ChatObject(
      {@required this.image,
      @required this.name,
      @required this.recentMessage,
      @required this.date});
}

class ChatListWidget extends StatelessWidget {
  final String? slideKey;
  final Function()? onPressed;
  final SlidableController? slidableController;
  final Function(SlideActionType?)? onDismissed;
  final Function()? onTapCamera;
  final Function()? onTapProfile;
  final Function()? onTapDelete;
  final Function()? onTapEye;
  final ChatObject? chatObject;

  const ChatListWidget(
      {@required this.slideKey,
      @required this.chatObject,
      this.onPressed,
      this.slidableController,
      this.onDismissed,
      this.onTapCamera,
      this.onTapProfile,
      this.onTapDelete,
      this.onTapEye});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: onDismissed,
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        SlideAction(
          child: SvgPicture.asset(
            Assets.camera,
            color: Colors.white,
            height: 18.h,
          ),
          color: DColors.primaryColor,
          onTap: onTapCamera,
        ),
        SlideAction(
            child: SvgPicture.asset(
              Assets.profile,
              color: Colors.white,
              height: 18.h,
            ),
            color: DColors.primaryColor,
            onTap: onTapProfile)
      ],
      secondaryActions: [
        SlideAction(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.eye,
                  height: 12.h,
                ),
                SizedBox(height: 5),
                TextWidget(
                  text: "1",
                  size: FontSize.s10,
                  appcolor: DColors.white,
                )
              ],
            ),
            color: Colors.red,
            onTap: onTapEye),
        SlideAction(
            child: SvgPicture.asset(
              Assets.delete,
              color: Colors.white,
              height: 18.h,
            ),
            color: Colors.red,
            onTap: onTapDelete)
      ],
      key: Key(slideKey!),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleImageHandler(
                chatObject!.image!.isNotEmpty &&
                        !chatObject!.image!.contains('https://')
                    ? 'https://${chatObject!.image}'
                    : chatObject!.image,
                radius: 20,
                showInitialText: chatObject!.image!.isEmpty,
                initials: Helpers.getInitials(chatObject?.name ?? ''),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: chatObject?.name ?? '',
                      size: FontSize.s16,
                      weight: FontWeight.w500,
                      appcolor: DColors.mildDark,
                    ),
                    TextWidget(
                      text: chatObject?.recentMessage ?? '',
                      size: FontSize.s14,
                      weight: FontWeight.w400,
                      appcolor: DColors.grey,
                    ),
                  ],
                ),
              ),
              TextWidget(
                text: chatObject?.date ?? '',
                size: FontSize.s12,
                weight: FontWeight.w400,
                appcolor: DColors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
