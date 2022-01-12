import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleImageHandler extends StatelessWidget {
  final String? image;
  final double? radius;
  final double? borderWidth;
  final bool? showInitialText;
  final String? initials;
  final Color? borderColor;
  final File? imageFile;
  const CircleImageHandler(this.image,
      {Key? key,
      this.radius = 25,
      this.borderWidth = 0.0,
      this.showInitialText = false,
      this.initials = '',
      this.imageFile,
      this.borderColor = DColors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return CircleAvatar(
        radius: radius!.r,
        backgroundImage: FileImage(imageFile!),
      );
    }
    if (showInitialText!) {
      return CircleAvatar(
        radius: radius?.r,
        backgroundColor: DColors.lightGrey,
        child: Text(
          initials ?? '',
          style: TextStyle(color: DColors.white, fontSize: 16.sp),
        ),
      );
    }
    if (image!.contains('https') || image!.isEmpty) {
      return CircularProfileAvatar(
        image!,
        radius: radius!.r,
        backgroundColor: DColors.lightGrey,
        borderWidth: borderWidth!,
        borderColor: borderColor!,
        cacheImage: true,
        initialsText: showInitialText!
            ? Text(
                initials!,
                style: TextStyle(color: DColors.white),
              )
            : Text(''),
        showInitialTextAbovePicture: showInitialText!,
        placeHolder: (context, url) => CircleAvatar(
          radius: radius!.r,
          backgroundColor: DColors.lightGrey,
        ),
        errorWidget: (context, url, _) => CircleAvatar(
          radius: radius?.r,
          backgroundColor: DColors.lightGrey,
        ),
      );
    }
    return Container();
  }
}
