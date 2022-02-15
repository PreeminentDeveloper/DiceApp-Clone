import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Bubble extends StatelessWidget {
  ListOfMessages? chat;
  Bubble(this.chat);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 33.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 19.1, top: 8, bottom: 8, right: 48.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: .5,
                        spreadRadius: 1.0,
                        color: Colors.black.withOpacity(.12))
                  ],
                  color: DColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    bottomLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SizedBox(
                  width: chat?.message != null &&
                          chat!.message!.isNotEmpty &&
                          chat!.message!.length > 50
                      ? 160.w
                      : null,
                  child: TextWidget(
                    text: chat?.message ?? '',
                    type: "Circular",
                    appcolor: DColors.white,
                    size: 13,
                    align: TextAlign.left,
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(width: 17.2.w),
              Visibility(
                  visible: true,
                  child: chat?.read != null
                      ? SvgPicture.asset("assets/delivered.svg")
                      : SvgPicture.asset(
                          "assets/ssent_icon.svg",
                          width: 24,
                          fit: BoxFit.cover,
                        ))
            ],
          ),
          const SizedBox(height: 8.9),
          Container(
            margin: EdgeInsets.only(bottom: 16.4.h),
            child: TextWidget(
              text: TimeUtil.chatTime(chat?.insertedAt ?? ''),
              size: FontSize.s8,
              align: TextAlign.right,
              type: "Objectivity",
            ),
          ),
        ],
      ),
    );
  }
}
