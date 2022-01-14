import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _imageOne =
    "https://images.unsplash.com/photo-1636942099353-f8d8edac22c7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60";
final _imageTwo =
    "https://images.unsplash.com/photo-1636912305077-eb89d5ede5b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=774&q=80";

class TextersImagePreview extends StatelessWidget {
  final userInfo;
  const TextersImagePreview({Key? key, this.userInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: SizeConfig.getDeviceWidth(context) * .4,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              Stack(
                children: [
                  CircleImageHandler("https://" + userInfo.photo),
                  Positioned(
                    top: 37,
                    right: 36,
                    child: CircleAvatar(
                      radius: 8.r,
                      backgroundColor: DColors.white,
                      child: CircleAvatar(
                          radius: 5.r,
                          backgroundColor: DColors.primaryAccentColor),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 95.w,
                child: Stack(
                  children: [
                    CircleImageHandler(
                      _imageTwo,
                      borderWidth: 5,
                      radius: 30.r,
                    ),
                    Positioned(
                      top: 40,
                      left: 40,
                      child: CircleAvatar(
                        radius: 8.r,
                        backgroundColor: DColors.white,
                        child: CircleAvatar(
                            radius: 5.r, backgroundColor: DColors.amber),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 7.h),
        Container(
          width: SizeConfig.getDeviceWidth(context) * .4,
          margin:
              EdgeInsets.only(left: SizeConfig.getDeviceWidth(context) / 10),
          alignment: Alignment.center,
          child: TextWidget(
              text: userInfo.name,
              appcolor: DColors.black,
              align: TextAlign.center,
              size: FontSize.s14),
        )
      ],
    );
  }
}
