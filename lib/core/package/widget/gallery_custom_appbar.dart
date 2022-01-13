import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GalleryCustomAppBar extends StatelessWidget {
  const GalleryCustomAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 38.w, right: 38.w, top: 38.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: "Album",
                appcolor: DColors.primaryColor,
                size: FontSize.s16,
                weight: FontWeight.w500,
              ),
              TextWidget(
                text: "Photos",
                appcolor: DColors.black,
                size: FontSize.s17,
                weight: FontWeight.w500,
              ),
              TextWidget(
                text: "Cancel",
                appcolor: DColors.primaryColor,
                size: FontSize.s16,
                weight: FontWeight.w500,
                onTap: () => PageRouter.goBack(context),
              ),
            ],
          ),
        ),
        CustomeDivider(thickness: 0.3),
        Padding(
          padding:
              EdgeInsets.only(left: 38.w, right: 38.w, top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/camera.svg",
                height: 22,
                color: DColors.primaryColor,
              ),
              SizedBox(width: 35.6.w),
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(
                      "assets/play.svg",
                      height: 20,
                    )),
                onTap: () {},
              ),
              SizedBox(width: 35.6.w),
              SvgPicture.asset(
                "assets/gif.svg",
                height: 20,
              ),
            ],
          ),
        ),
        CustomeDivider(thickness: 0.3),
      ],
    );
  }
}
