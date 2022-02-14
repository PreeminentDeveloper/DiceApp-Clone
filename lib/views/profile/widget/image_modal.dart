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
  final Function()? deletePhoto;
  final bool? showDeleteButton;
  const ImageModal(
      {this.fileCallBack,
      this.deletePhoto,
      Key? key,
      this.showDeleteButton = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showDeleteButton!,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Helpers.getDeviceWidth(context),
                    child: TextWidget(
                      text: "Delete Photo",
                      size: FontSize.s16,
                      weight: FontWeight.w400,
                      appcolor: DColors.red,
                      align: TextAlign.center,
                      onTap: deletePhoto,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const Divider(),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            SizedBox(
              width: Helpers.getDeviceWidth(context),
              child: TextWidget(
                text: "Take photo",
                size: FontSize.s16,
                weight: FontWeight.w400,
                appcolor: DColors.primaryAccentColor,
                align: TextAlign.center,
                onTap: () async {
                  final _file =
                      await Helpers.processImage(context, ImageSource.camera);
                  fileCallBack!(_file);
                },
              ),
            ),
            SizedBox(height: 8.h),
            const Divider(),
            SizedBox(height: 8.h),
            SizedBox(
              width: Helpers.getDeviceWidth(context),
              child: TextWidget(
                text: "Choose photo",
                size: FontSize.s16,
                weight: FontWeight.w400,
                appcolor: DColors.primaryAccentColor,
                align: TextAlign.center,
                onTap: () async {
                  final _file =
                      await Helpers.processImage(context, ImageSource.gallery);
                  fileCallBack!(_file);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
