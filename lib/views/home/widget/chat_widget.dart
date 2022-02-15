import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class ChatObject {
  final String? image;
  final String? name;
  final String? recentMessage;
  final String? date;
  final int? viewersCount;
  final int? unread;
  final String? lastMessage;

  ChatObject(
      {@required this.image,
      @required this.name,
      @required this.recentMessage,
      @required this.date,
      @required this.viewersCount,
      @required this.unread,
      @required this.lastMessage});
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
          child: const SlidableDrawerDismissal(), onDismissed: onDismissed),
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        // SlideAction(
        //   child: SvgPicture.asset(
        //     Assets.camera,
        //     color: Colors.white,
        //     height: 18.h,
        //   ),
        //   color: DColors.primaryColor,
        //   onTap: onTapCamera,
        // ),
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
                const SizedBox(height: 5),
                TextWidget(
                  text: '${chatObject?.viewersCount ?? 0}',
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
              AdvancedAvatar(
                statusSize: 16,
                size: 50,
                child: CircleImageHandler(
                  chatObject!.image!.isNotEmpty &&
                          !chatObject!.image!.contains('https://')
                      ? 'https://${chatObject!.image}'
                      : chatObject!.image,
                  radius: 50,
                  showInitialText: chatObject!.image!.isEmpty,
                  initials: Helpers.getInitials(chatObject?.name ?? ''),
                ),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: chatObject!.unread! > 0
                        ? DColors.primaryColor.withOpacity(0.75)
                        : Colors.white,
                    width: 3,
                  ),
                ),
                bottomLeft: Visibility(
                  visible: chatObject!.unread! > 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      ),
                      color: DColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: TextWidget(
                      text: '${chatObject?.unread ?? 0}',
                      size: FontSize.s10,
                      weight: FontWeight.w300,
                      appcolor: DColors.white,
                    ),
                  ),
                ),
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
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 1),
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
