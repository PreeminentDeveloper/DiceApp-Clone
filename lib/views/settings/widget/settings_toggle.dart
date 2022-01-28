import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class StatusToggle extends StatelessWidget {
  final String? text;
  final bool? boolVal;
  final Function(bool)? onToggle;

  const StatusToggle({this.text, this.boolVal, this.onToggle, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: SizeConfig.appPadding!, vertical: 3),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: text,
            size: FontSize.s16,
            weight: FontWeight.w500,
            appcolor: DColors.mildDark,
            type: "Objectivity",
          ),
          Spacer(),
          FlutterSwitch(
            // showOnOff: true,
            width: 55,
            height: 30,
            padding: 2,
            value: boolVal ?? false,
            inactiveColor: Color(0xffb3b3b3),
            activeColor: DColors.bgGrey,
            toggleColor: DColors.primaryColor,
            inactiveToggleColor: Color(0xff666666),
            switchBorder: Border.all(color: DColors.faded),
            onToggle: onToggle!,
          )
        ],
      ),
    );
  }
}
