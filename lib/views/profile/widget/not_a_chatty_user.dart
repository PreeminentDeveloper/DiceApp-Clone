import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';

class NotAChattyUser extends StatelessWidget {
  const NotAChattyUser({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              side: BorderSide(color: DColors.outputColor, width: 0.3)),
          child: Center(
            child: TextWidget(
              text: "This user is not actually\n very chatty",
              size: FontSize.s16,
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
    
  }
}
