
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/gif_grid.dart';
import 'widget/image_grid.dart';
import 'widget/video_grid.dart';

class StickersView extends StatefulWidget {
  final Function(dynamic image)? sticker;
  const StickersView({this.sticker, key}) : super(key: key);

  @override
  State<StickersView> createState() => _StickersViewState();
}

class _StickersViewState extends State<StickersView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 23.h),
        Container(
          width: SizeConfig.getDeviceWidth(context),
          color: DColors.bgGrey,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _container(
                  text: 'Image',
                  isSelected: _index == 0,
                  onTap: () => setState(() => _index = 0)),
              _container(
                  text: 'Video',
                  isSelected: _index == 1,
                  onTap: () => setState(() => _index = 1)),
              _container(
                  text: 'GIF',
                  isSelected: _index == 2,
                  onTap: () => setState(() => _index = 2)),
            ],
          ),
        ),
        SizedBox(height: 23.h),
        _bodySelection()
      ],
    );
  }

  Widget _bodySelection() {
    if (_index == 0) {
      return ImageGrid();
    }
    if (_index == 1) {
      return VideoGrid();
    }
    return GifGrid();
  }

  _container({String? text, bool? isSelected, Function()? onTap}) =>
      CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 8.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: !isSelected! ? Colors.transparent : DColors.white),
          child: TextWidget(
            text: text,
            appcolor: DColors.mildDark,
            weight: FontWeight.w400,
            size: FontSize.s17,
          ),
        ),
      );
}
