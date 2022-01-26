// ignore_for_file: prefer_const_constructors

import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/views/widgets/pop_menu/items.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/pop_menu_options.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatEditBox extends StatelessWidget {
  final Function(String)? onChanged;
  final bool? isEnabled;
  final bool? toggleSticekrDialog;
  final TextEditingController? msgController;
  final Function()? addMessage;
  final Function(String value)? showGeneralDialog;
  final Function(PopMenuOptions option)? onMenuPressed;
  final Function(bool v)? showStickerDialog;
  final Function()? pickImages;

  const ChatEditBox(
      {Key? key,
      @required this.onChanged,
      @required this.isEnabled,
      @required this.msgController,
      @required this.addMessage,
      @required this.showGeneralDialog,
      @required this.onMenuPressed,
      @required this.pickImages,
      this.showStickerDialog,
      this.toggleSticekrDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(color: Color(0xfff7f7f7)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: toggleSticekrDialog ?? false,
            child: _stickerDialog(),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: const Color(0xff6F7170), width: 0.5),
                  color: Colors.white),
              // height: 40,
              child: Row(
                crossAxisAlignment: isEnabled!
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      onChanged: onChanged,
                      controller: msgController,
                      maxLines: null,
                      onTap: () => showStickerDialog ?? (false),
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        // fillColor: DColors.white,
                        hintStyle: TextStyle(
                          color: Color(0xff808080),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        // filled: true,
                        border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),
                  ),
                  if (isEnabled!)
                    GestureDetector(
                        onTap: addMessage,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: SvgPicture.asset(
                              "assets/send.svg",
                              height: 20,
                            ))),
                  if (!isEnabled!)
                    // PopMenuWidget(
                    //   primaryWidget: Container(
                    //       padding: const EdgeInsets.all(16),
                    //       child: SvgPicture.asset("assets/add.svg")),
                    //   menuItems: PostsMenuModel.chatStickers(),
                    //   menuCallback: (option) => showStickerDialog!(true),
                    // ),
                    GestureDetector(
                      onTap: () => showStickerDialog!(!toggleSticekrDialog!),
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: SvgPicture.asset("assets/add.svg")),
                    ),
                  if (!isEnabled!)
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SvgPicture.asset("assets/camera.svg")),
                ],
              )),
        ],
      ),
    );
  }

  GestureDetector _stickerDialog() {
    return GestureDetector(
      onTap: pickImages,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                color: DColors.grey,
                blurRadius: 0.1,
                spreadRadius: 0.0,
                offset: Offset(0.0, 0.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/gallery.svg',
                color: DColors.grey400,
                height: 15,
              ),
              SizedBox(width: 15.w),
              TextWidget(
                  text: 'Photo & video',
                  align: TextAlign.left,
                  appcolor: DColors.grey400),
            ],
          ),
        ),
      ),
    );
  }
}
