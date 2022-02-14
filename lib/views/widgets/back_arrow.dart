import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrow extends StatelessWidget {
  final Function()? onBackTapped;

  BackArrow({this.onBackTapped});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: onBackTapped ?? () => PageRouter.goBack(context),
        child: Container(
          margin: EdgeInsets.only(
              left: SizeConfig.sizeXXL!, bottom: SizeConfig.sizeXL!),
          padding: const EdgeInsets.all(8.5),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset("assets/back.svg"),
        ),
      ),
    );
  }
}
