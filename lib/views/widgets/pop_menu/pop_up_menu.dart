
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../textviews.dart';
import 'custom_pop_menu.dart';
import 'items.dart';
import 'pop_menu_options.dart';

final CustomPopupMenuController controller = CustomPopupMenuController();

// ignore: must_be_immutable
class PopMenuWidget extends StatelessWidget {
  final Widget? primaryWidget;
  List<dynamic>? menuItems;
  Function(dynamic)? menuCallback;

  PopMenuWidget(
      {Key? key,
      @required this.primaryWidget,
      @required this.menuItems,
      this.menuCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: primaryWidget,
      showArrow: false,
      menuBuilder: () => Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menuItems!
                .map(
                  (item) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => menuCallback!(item.options),
                    child: Container(
                      width: SizeConfig.getDeviceWidth(context) * .4,
                      padding: EdgeInsets.symmetric(
                          horizontal: 23.w, vertical: 10.h),
                      child: TextWidget(
                          text: item.title ?? '',
                          align: TextAlign.left,
                          appcolor: item?.color ?? DColors.black),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: controller,
    );
  }
}
