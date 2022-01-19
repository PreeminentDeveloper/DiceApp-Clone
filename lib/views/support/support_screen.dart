import 'package:dice_app/core/util/appstring.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: defaultAppBar(context, title: 'Support'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.sizeLarge),
              TextWidget(
                text: 'Dice is an open world\nMessaging Platform',
                appcolor: const Color(0xffC7C7C7),
                size: 20.sp,
                weight: FontWeight.bold,
                align: TextAlign.center,
              ),
              SizedBox(height: 37.6.h),
              Image.asset('assets/dots.png'),
              SizedBox(height: 36.2.h),
              Image.asset(
                'assets/support_icon.png',
                height: 294.27.h,
                width: 272.21.w,
              ),
              SizedBox(height: 44.7.h),
              TextWidget(
                text: 'Reach out to us and know more;',
                appcolor: DColors.black,
                size: 14.sp,
                weight: FontWeight.normal,
                align: TextAlign.center,
              ),
              TextWidget(
                text: AppString.supportURL,
                appcolor: DColors.primaryAccentColor,
                size: 14.sp,
                weight: FontWeight.normal,
                align: TextAlign.center,
                onTap: () =>
                    Helpers.launchURL('https://${AppString.supportURL}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
