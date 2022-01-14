import 'package:dice_app/core/util/appstring.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultAppBar(context, title: '', elevation: 0),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(Assets.logoWithName),
                SizedBox(height: 50.4.h),
                TextWidget(
                  text: 'Privacy',
                  type: "Objectivity",
                  size: FontSize.s40,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                TextWidget(
                  text: 'Updated October 28, 2020',
                  type: "Objectivity",
                  size: FontSize.s13,
                  weight: FontWeight.normal,
                ),
                SizedBox(height: 50.h),
                TextWidget(
                  text: AppString.privacy,
                  type: "Objectivity",
                  size: FontSize.s16,
                  height: 1.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
