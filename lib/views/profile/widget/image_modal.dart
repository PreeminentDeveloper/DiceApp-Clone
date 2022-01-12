import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageModal extends StatelessWidget {
  final Function(File? file)? fileCallBack;
  const ImageModal({this.fileCallBack, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: "Delete Photo",
              size: FontSize.s16,
              weight: FontWeight.w400,
              appcolor: DColors.red,
              align: TextAlign.center,
              onTap: () {
                PageRouter.goBack(context);
              },
            ),
            SizedBox(height: 8.h),
            const Divider(),
            SizedBox(height: 8.h),
            TextWidget(
              text: "Take photo",
              size: FontSize.s16,
              weight: FontWeight.w400,
              appcolor: DColors.blue100,
              align: TextAlign.center,
              onTap: () async {
                final _file = await Helpers.processImage(ImageSource.camera);
                fileCallBack!(_file);
              },
            ),
            SizedBox(height: 8.h),
            const Divider(),
            SizedBox(height: 8.h),
            TextWidget(
              text: "Choose photo",
              size: FontSize.s16,
              weight: FontWeight.w400,
              appcolor: DColors.blue100,
              align: TextAlign.center,
              onTap: () async {
                final _file = await Helpers.processImage(ImageSource.gallery);
                fileCallBack!(_file);
              },
            ),
          ],
        ),
      ),
    );
  }
}
