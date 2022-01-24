import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/support/support_screen.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'badges.dart';

class AdditionalService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: defaultAppBar(context, title: "Additional Services"),
      body: Container(
        // margin: EdgeInsets.all(SizeConfig.appPadding),
        child: ListView(
          children: [
            GreyContainer(title: "More Information on Using Dice"),
            SizedBox(height: SizeConfig.sizeLarge),
            GestureDetector(
                onTap: () => PageRouter.gotoWidget(SupportScreen(), context),
                child: _item("Support")),
            SizedBox(height: 6.9.h),
            CustomeDivider(),
            SizedBox(height: 6.9.h),
            GestureDetector(
              child: _item("Badges"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Badges()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeLarge!),
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
    );
  }
}
