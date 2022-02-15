import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupedTimer extends StatelessWidget {
  final String groupByValue;
  const GroupedTimer(this.groupByValue, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
      child: Row(
        children: [
          Expanded(child: CustomeDivider(thickness: .3)),
          TextWidget(
            text: TimeUtil.timeAgoSinceDate(groupByValue),
            appcolor: const Color(0xffB2B2B2),
            weight: FontWeight.w500,
            size: 10.sp,
          ),
          Expanded(child: CustomeDivider(thickness: .3)),
        ],
      ),
    );
  }
}
