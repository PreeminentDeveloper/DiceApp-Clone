
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Badges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: defaultAppBar(context, title: 'Badges'),
      body: Container(
        margin: EdgeInsets.all(SizeConfig.sizeMedium!),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Badges and Trophies',
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
                    'Badges are your achievements, streaks, stickers and gifts you’ve collected or earned. So start adding up friends, levelling up and collecting those badge of awesomeness!',
                type: "Objectivity",
                size: FontSize.s14,
                weight: FontWeight.normal,
                align: TextAlign.left,
                height: 1.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
