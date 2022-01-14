import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppPermissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.white,
      body: Container(
        alignment: Alignment.center,
        child: SvgPicture.asset("assets/permission-icon.svg"),
      ),
    );
  }
}
