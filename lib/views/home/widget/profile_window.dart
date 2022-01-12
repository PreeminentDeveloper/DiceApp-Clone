import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileWindow extends StatelessWidget {
  final bool value;
  final clicked;

  const ProfileWindow(this.clicked, {Key? key, this.value = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        CircleImageHandler(
          'https://host/url',
          radius: 20,
          showInitialText: true,
          initials: Helpers.getInitials('JC'),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text: 'Name',
                size: FontSize.s14,
                weight: FontWeight.w700,
                appcolor: DColors.mildDark,
              ),
              SizedBox(height: SizeConfig.sizeExtraSmall),
              TextWidget(
                text: value ? "About..." : '',
                size: FontSize.s12,
                weight: FontWeight.w500,
                appcolor: DColors.grey,
              )
            ],
          ),
        ),
        GestureDetector(
            onTap: () {
              clicked();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: DColors.inputText),
                child: SvgPicture.asset(
                  Assets.assetArrow,
                  color: DColors.white,
                ))),
      ]),
    );
  }
}
