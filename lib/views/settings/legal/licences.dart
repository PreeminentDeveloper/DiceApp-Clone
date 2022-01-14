import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Licenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Licenses'),
      body: Container(
        margin: EdgeInsets.all(SizeConfig.sizeMedium!),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Dice Licenses Agreements',
                type: "Objectivity",
                size: FontSize.s20,
                weight: FontWeight.bold,
                appcolor: DColors.black400,
                align: TextAlign.center,
                height: 1.6,
              ),
              SizedBox(height: 50.h),
              TextWidget(
                text:
                    'THERE ARE A SERIES OF THIRD PARTY SOFTWARE THAT MAYBE INCLUDED IN PORTIONS OF DICE.\n\nTO FIND OUT MORE, KINDLY SEND A MAIL TO:',
                type: "Objectivity",
                size: FontSize.s14,
                weight: FontWeight.normal,
                align: TextAlign.left,
                height: 1.6,
              ),
              TextWidget(
                text: 'support@dicemessenger.com',
                type: "Objectivity",
                size: FontSize.s14,
                weight: FontWeight.normal,
                align: TextAlign.left,
                appcolor: DColors.primaryAccentColor,
                height: 1.6,
                onTap: () =>
                    Helpers.launchURL('mailto:support@dicemessenger.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
