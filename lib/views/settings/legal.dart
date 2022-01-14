import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/appstring.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'legal/licences.dart';
import 'legal/policy.dart';
import 'legal/terms.dart';

class Legal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: defaultAppBar(context, title: 'Legal'),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.sizeLarge),
          _item("Terms of Use",
              onTap: () => PageRouter.gotoWidget(Terms(), context)),
          SizedBox(height: 6.9.h),
          CustomeDivider(),
          SizedBox(height: 6.9.h),
          _item("Privacy Policy",
              onTap: () => PageRouter.gotoWidget(Policy(), context)),
          SizedBox(height: 6.9.h),
          CustomeDivider(),
          SizedBox(height: 6.9.h),
          _item("Licenses",
              onTap: () => PageRouter.gotoWidget(Licenses(), context)),
          SizedBox(height: 6.9.h),
          Spacer(),
          _item("About Dice", onTap: () {
            Helpers.launchURL(AppString.aboutDice);
          }),
          Spacer()
        ],
      ),
    );
  }

  Widget _item(text, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
                text: text,
                size: FontSize.s16,
                weight: FontWeight.w500,
                appcolor: DColors.mildDark,
                type: "Objectivity"),
            SvgPicture.asset("assets/arrow-forward.svg")
          ],
        ),
      ),
    );
  }
}
