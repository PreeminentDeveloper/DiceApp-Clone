import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreyContainer extends StatelessWidget {
  final title;
  GreyContainer({this.title});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: DColors.bgGrey,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      height: SizeConfig.sizeXXL,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextWidget(
        text: title,
        type: "Objectivity",
        size: FontSize.s13,
        weight: FontWeight.w700,
        appcolor: DColors.lightGrey,
      ),
    );
  }
}

class GreyContainerRow extends StatelessWidget {
  final title, length;
  GreyContainerRow({this.title, this.length});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        color: DColors.bgGrey,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: SizeConfig.sizeXXL,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: title,
              type: "Objectivity",
              size: FontSize.s13,
              weight: FontWeight.w700,
              appcolor: DColors.lightGrey,
            ),
            TextWidget(
              text: length.toString(),
              type: "Objectivity",
              size: FontSize.s13,
              weight: FontWeight.w700,
              appcolor: DColors.lightGrey,
            )
          ],
        ));
  }
}
