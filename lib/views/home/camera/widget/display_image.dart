import 'dart:io';

import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/views/chat/feature_images.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'display_video.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final ImageObject? object;

  const DisplayPictureScreen({Key? key, required this.object})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: '', backgroundColor: Colors.black),
      body: Stack(
        children: [
          Image.file(
            File(object!.path!),
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          GestureDetector(
            onTap: () {
              PageRouter.gotoWidget(
                  FeatureImages([File(object!.path!)], object?.user?.name ?? '',
                      object?.conversationID ?? ''),
                  context);
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
                margin: EdgeInsets.all(23.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: DColors.primaryColor),
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
