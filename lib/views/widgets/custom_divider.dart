import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeDivider extends StatelessWidget {
  final double thickness;

  CustomeDivider({this.thickness = .5});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Divider(thickness: thickness, color: DColors.lightGrey));
  }
}
