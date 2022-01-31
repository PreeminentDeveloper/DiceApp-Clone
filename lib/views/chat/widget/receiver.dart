import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/models/chat_menus.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/widgets/pop_menu/custom_pop_menu.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import 'image_viewer.dart';

class ReceiverSide extends StatelessWidget {
  final LocalChatModel? chat;
  final Function()? deleteCallback;

  const ReceiverSide({this.chat, this.deleteCallback, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 23.3.h),
      width: SizeConfig.getDeviceWidth(context) * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PopMenuWidget(
            primaryWidget: chat?.messageType == "media"
                ? _displayImage(chat?.messageFromEvent, context)
                : Container(
                    decoration: BoxDecoration(
                        color: DColors.white,
                        border: Border.all(color: DColors.lightGrey, width: .5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 60),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextWidget(
                      text: chat?.message ?? '',
                      type: "Circular",
                      appcolor: DColors.mildDark,
                      height: 1.6,
                    )),
            menuItems: ChatMenu.chatMenu(),
            pressType: PressType.longPress,
            menuCallback: (option) {
              if (ChatOptions.delete == option) {
                deleteCallback!();
                controller.hideMenu();
              } else {
                controller.hideMenu();
              }
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 50),
            alignment: Alignment.centerLeft,
            child: TextWidget(
              text: TimeUtil.chatTime(chat?.insertLocalTime ?? ''),
              size: FontSize.s8,
            ),
          )
        ],
      ),
    );
  }

  Widget _displayImage(Message? message, BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 10, 150, 10),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...message!.medias!.map((e) {
              return GestureDetector(
                onTap: () => PageRouter.gotoWidget(
                    ImageViewer('https://${e.hostname}/${e.url}'), context,
                    animationType: PageTransitionType.fade),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffCBCBCB)),
                    color: DColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(
                          tag: e.url ?? '',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r),
                              bottomRight: Radius.circular(15.r),
                            ),
                            child: Image.network(
                              'https://${e.hostname}/${e.url}',
                              fit: BoxFit.cover,
                              height: 156.54.h,
                              width: 357.52.w,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          child: TextWidget(
                            text: e.caption ?? '',
                            type: "Circular",
                            appcolor: DColors.white,
                            height: 1.6,
                            align: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
