import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'media_grid.dart';

class FlutterGallery {
  static Future<bool> requestPermission() async {
    return await PhotoManager.requestPermission();
  }

  static Future<List<AssetEntity>> pickGallery({
    @required BuildContext? context,
    @required String? title,
    @required Color? color,
    @required int? limit,
    int? maximumFileSize, // file size
  }) async {
    List<AssetEntity>? result;

    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context!,
        isScrollControlled: true,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.965,
              child: Scaffold(
                body: MediaGrid(
                  // CONSUME SELECTED ITEMS HERE, FOR EXAMPLE
                  title: title!,
                  color: color!,
                  limit: limit!,
                  maximumFileSize: maximumFileSize!,
                  onItemsSelected: (assets) {
                    result = assets;
                    Navigator.pop(context);
                  },
                ),
              ),
            ));
    return result!;
  }
}
