import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileWindow extends StatelessWidget {
  final bool value;
  final clicked;

  const ProfileWindow(this.clicked, {Key? key, this.value = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            CircleImageHandler(
              'https://${provider.user?.photo?.hostname}/${provider.user?.photo?.url}',
              radius: 20.r,
              showInitialText: provider.user?.photo?.url?.isEmpty ?? true,
              initials: Helpers.getInitials(provider.user?.name ?? ''),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      text: provider.user?.name ?? '',
                      size: FontSize.s14,
                      weight: FontWeight.w700,
                      appcolor: DColors.mildDark,
                    ),
                    SizedBox(height: SizeConfig.sizeExtraSmall),
                    TextWidget(
                      text: provider.user?.bio ?? 'About...',
                      size: FontSize.s12,
                      weight: FontWeight.w500,
                      appcolor: DColors.grey,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  clicked();
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: DColors.inputText),
                    child: SvgPicture.asset(
                      Assets.assetArrow,
                      color: DColors.white,
                    ))),
          ]),
        );
      },
    );
  }
}
