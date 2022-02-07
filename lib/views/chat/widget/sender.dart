import 'dart:io';

import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/models/chat_menus.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:dice_app/views/widgets/pop_menu/custom_pop_menu.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'image_viewer.dart';

class SenderSide extends StatelessWidget {
  final ListOfMessages? chat;
  final Function? deleteCallback;
  const SenderSide({this.chat, this.deleteCallback, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 48.6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: SizeConfig.getDeviceWidth(context) * .7,
                child: PopMenuWidget(
                  primaryWidget: chat!.medias!.isNotEmpty
                      ? _displayImage(chat!.medias, context)
                      : Container(
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                              color: DColors.primaryColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 25, right: 60),
                          margin: const EdgeInsets.fromLTRB(20, 10, 17.2, 0),
                          child: TextWidget(
                            text: chat?.message ?? '',
                            type: "Circular",
                            appcolor: DColors.white,
                            align: TextAlign.left,
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
              chat?.read != null
                  ? SvgPicture.asset("assets/delivered.svg")
                  : SvgPicture.asset(
                      "assets/ssent_icon.svg",
                      width: 24,
                      fit: BoxFit.cover,
                    )
            ],
          ),
        ),
        SizedBox(height: 8.9.h),
        Container(
          margin: EdgeInsets.only(right: 30.7.w, bottom: 16.4.h),
          child: TextWidget(
            text: TimeUtil.chatTime(chat?.insertedAt ?? ''),
            size: FontSize.s8,
            align: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _displayImage(List<Medias>? medias, BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...medias!.map((e) {
            if (e.url!.contains('mp4')) {
              return FutureBuilder(
                  future: _fetchThumbNails('https://${e.hostname}/${e.url}'),
                  builder: (_, snap) {
                    if (snap.connectionState == ConnectionState.waiting ||
                        !snap.hasData) return Container();
                    return GestureDetector(
                      onTap: () => PageRouter.gotoWidget(
                          ImageViewer('https://${e.hostname}/${e.url}',
                              video: true),
                          context,
                          animationType: PageTransitionType.fade),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(90, 10, 17.2, 0),
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
                                tag: 'https://${e.hostname}/${e.url}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r),
                                    bottomLeft: Radius.circular(15.r),
                                  ),
                                  child: Image.file(File(snap.data.toString()),
                                      height: 156.54.h,
                                      width: 357.52.w,
                                      fit: BoxFit.cover),
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
                  });
            }
            return GestureDetector(
              onTap: () => PageRouter.gotoWidget(
                  ImageViewer('https://${e.hostname}/${e.url}'), context,
                  animationType: PageTransitionType.fade),
              child: Container(
                margin: const EdgeInsets.fromLTRB(90, 10, 17.2, 0),
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
                        tag: 'https://${e.hostname}/${e.url}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomLeft: Radius.circular(15.r),
                          ),
                          child: ImageLoader(
                              height: 156.54.h,
                              width: 357.52.w,
                              imageLink: 'https://${e.hostname}/${e.url}',
                              fit: BoxFit.cover),
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
    );
  }

  Future<String?> _fetchThumbNails(String url) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 64,
      quality: 75,
    );
    return fileName;
  }
}
