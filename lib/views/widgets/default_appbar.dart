import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';

import 'textviews.dart';

defaultAppBar(BuildContext context,
    {String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    Widget? leading,
    double? titleSpacing,
    double? leadingWidth,
    bool? centerTitle = true,
    bool? automaticallyImplyLeading = true,
    Color? backgroundColor,
    double? elevation = 1,
    Function()? onTap}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(90),
    child: GestureDetector(
      onTap: onTap,
      child: AppBar(
        backgroundColor: backgroundColor ?? DColors.white,
        toolbarHeight: 90,
        leadingWidth: leadingWidth,
        titleSpacing: titleSpacing,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading!,
        elevation: elevation,
        title: titleWidget ??
            TextWidget(
              text: title ?? '',
              appcolor: DColors.black,
            ),
        leading: leading ??
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => PageRouter.goBack(context),
                icon: const Icon(Icons.arrow_back, color: Palette.diceColor)),
        actions: actions,
      ),
    ),
  );
}
