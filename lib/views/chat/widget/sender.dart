import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import 'image_viewer.dart';

class SenderSide extends StatelessWidget {
  final LocalChatModel? chat;
  final Function? deleteCallback;
  const SenderSide({this.chat, this.deleteCallback, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 23.3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 23.3.h),
                width: SizeConfig.getDeviceWidth(context) * .7,
                child: PopMenuWidget(
                  primaryWidget: Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                          color: DColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 60),
                      margin: const EdgeInsets.fromLTRB(50, 10, 20, 10),
                      child: TextWidget(
                        text: chat?.message ?? '',
                        type: "Circular",
                        appcolor: DColors.white,
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
              ),
              Container(
                  margin: const EdgeInsets.only(right: 38, bottom: 10),
                  child: SvgPicture.asset("assets/delivered.svg"))
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: TextWidget(
              text: Helpers.chatTime(chat?.insertLocalTime ?? ''),
              size: FontSize.s8,
            ),
          )
        ],
      ),
    );
  }
}
