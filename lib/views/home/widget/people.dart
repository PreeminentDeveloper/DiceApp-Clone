import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dice_app/views/widgets/circle_image.dart';

class People extends StatelessWidget {
  final String? text, subText, personId, photo;
  const People(this.text, this.subText, this.personId, this.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.appPadding!),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleImageHandler(
            photo ?? '',
            radius: 20.r,
            showInitialText: photo?.isEmpty ?? true,
            initials: Helpers.getInitials(text ?? ''),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: text ?? "",
                  size: FontSize.s16,
                  weight: FontWeight.w500,
                  appcolor: DColors.mildDark,
                ),
                const SizedBox(height: 5),
                TextWidget(
                  text: subText ?? "",
                  size: FontSize.s10,
                  weight: FontWeight.w500,
                  appcolor: DColors.lightGrey,
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OtherProfile(personId!)));
              },
              child: SvgPicture.asset("assets/arrow-forward.svg")),
        ],
      ),
    );
  }
}
