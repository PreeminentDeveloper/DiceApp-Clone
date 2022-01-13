import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetHeader extends StatelessWidget {
  final String header, icon;
  const BottomSheetHeader({Key? key, required this.header, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, color: DColors.actions),
        SizedBox(width: SizeConfig.sizeLarge),
        TextWidget(
          text: header,
          appcolor: DColors.sheetColor,
          weight: FontWeight.w700,
          type: "Objectivity",
          size: FontSize.s14,
        ),
        const Spacer(),
        header == "Chat Notifications"
            ? TextWidget(
                text: "Clear",
                appcolor: DColors.faded,
                weight: FontWeight.w700,
                type: "Objectivity",
                size: FontSize.s12,
              )
            : Container(),
      ],
    );
  }
}
