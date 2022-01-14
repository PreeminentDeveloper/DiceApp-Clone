import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'change_number.dart';
import 'change_username.dart';

class AccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: defaultAppBar(context, title: 'Account Settings'),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                GreyContainer(title: "Change Account Settings"),
                SizedBox(height: SizeConfig.sizeLarge),
                GestureDetector(
                  child: _item("Edit Username"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChangeUsername()));
                  },
                ),
                SizedBox(height: 6.9.h),
                CustomeDivider(),
                SizedBox(height: 6.9.h),
                GestureDetector(
                  child: _item("Change Phone Number"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChangeNumber()));
                  },
                ),
                // Spacer(),
                CustomeDivider(),
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(SizeConfig.appPadding!),
              child: TextWidget(
                  text: "Delete Account",
                  appcolor: Colors.red,
                  weight: FontWeight.w500,
                  size: FontSize.s18),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(text) {
    return Container(
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
          SvgPicture.asset("assets/arrow-forward.svg"),
        ],
      ),
    );
  }
}
