import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/data/models/chat_menus.dart';
import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:dice_app/views/chat/data/models/sending_images.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:dice_app/views/widgets/pop_menu/custom_pop_menu.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: SizeConfig.getDeviceWidth(context) * .7,
            child: PopMenuWidget(
              primaryWidget: chat?.messageType == 'media'
                  ? _displayImage(chat?.imageSending, context)
                  : Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                          color: DColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 60),
                      margin: const EdgeInsets.fromLTRB(50, 10, 20, 10),
                      child: TextWidget(
                        text: chat?.message ?? '',
                        type: "Circular",
                        appcolor: DColors.white,
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
          ),
          Container(
              margin: const EdgeInsets.only(right: 38, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/delivered.svg"),
                  TextWidget(
                    text: Helpers.chatTime(chat?.insertLocalTime ?? ''),
                    size: FontSize.s8,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _displayImage(ImageSending? imageSending, BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...imageSending!.medias!
              .map((e) => GestureDetector(
                    onTap: () => PageRouter.gotoWidget(
                        ImageViewer(e.filePath, isFile: true), context,
                        animationType: PageTransitionType.fade),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(90, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffCBCBCB)),
                        color: DColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                          bottomLeft: Radius.circular(20.r),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: e.filePath ?? '',
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.r),
                                  topRight: Radius.circular(30.r),
                                  bottomLeft: Radius.circular(15.r),
                                ),
                                child: Image.file(
                                  File(e.filePath!),
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
                  ))
              .toList(),
        ],
      ),
    );
  }
}
