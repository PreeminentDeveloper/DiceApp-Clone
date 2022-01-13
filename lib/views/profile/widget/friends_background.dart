import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FriendsProfileImageBackground extends StatelessWidget {
  const FriendsProfileImageBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(90.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: Colors.red,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 200.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
    );
  }
}
