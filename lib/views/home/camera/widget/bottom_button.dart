import 'package:dice_app/core/util/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CameraButtongs extends StatelessWidget {
  final Function()? onClose;
  final Function()? onSwitch;
  final Function()? onCapture;
  final Function()? onVideoRecord;
  final Function()? gallery;
  final bool? isRecording;

  const CameraButtongs(
      {Key? key,
      this.onClose,
      this.onSwitch,
      this.onCapture,
      this.onVideoRecord,
      this.gallery,
      this.isRecording = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 100.h),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onClose, child: SvgPicture.asset(Assets.circleClose)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: onCapture,
                  onLongPress: onVideoRecord,
                  child: SvgPicture.asset(Assets.capture)),
              SizedBox(height: 21.5.h),
              GestureDetector(
                  onTap: gallery, child: SvgPicture.asset(Assets.gallery)),
            ],
          ),
          GestureDetector(
              onTap: onSwitch, child: SvgPicture.asset(Assets.switchCamera)),
        ],
      ),
    );
  }
}
