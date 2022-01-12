import 'package:flutter/material.dart';

void showModal(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.81,
        minChildSize: 0.5,
        maxChildSize: 0.81,
        builder: (ctx, scroll) => child),
  );
}
