import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/data/models/chat_menus.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
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
            primaryWidget: Container(
                decoration: BoxDecoration(
                    color: DColors.white,
                    border: Border.all(color: DColors.lightGrey, width: .5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 60),
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextWidget(
                  text: chat?.message ?? '',
                  type: "Circular",
                  appcolor: DColors.mildDark,
                  height: 1.6,
                )),
            menuItems: ChatMenu.chatMenu(),
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
              text: 'TimeAgo',
              // text: timeAgo(message.insertedAt),
              size: FontSize.s8,
            ),
          )
        ],
      ),
    );
  }
}
