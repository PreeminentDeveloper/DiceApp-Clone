import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';

showSheet(BuildContext context, {@required Widget? child}) =>
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [child!],
        cancelButton: CupertinoActionSheetAction(
          child: TextWidget(
            text: "Cancel",
            size: FontSize.s16,
            weight: FontWeight.w400,
            appcolor: DColors.blue100,
            align: TextAlign.center,
          ),
          onPressed: () {
            PageRouter.goBack(context);
          },
        ),
      ),
    );
