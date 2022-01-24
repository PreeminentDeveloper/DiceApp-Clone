import 'package:flutter/material.dart';

import '../pop_menu_options.dart';

class PostsMenuModel {
  String? image;
  String? title;
  PopMenuOptions? options;
  bool? showdivider;
  Color? color;

  PostsMenuModel(
      {this.image,
      this.title,
      this.options,
      this.showdivider = false,
      this.color});

  static List<PostsMenuModel> chatStickers() {
    List<PostsMenuModel> _itemModels = [];
    PostsMenuModel _item = PostsMenuModel(
        image: 'assets/gallery.svg',
        title: 'Photos & Video',
        showdivider: false,
        options: PopMenuOptions.photoAndVideo);

    _itemModels.add(_item);
    return _itemModels;
  }
}
