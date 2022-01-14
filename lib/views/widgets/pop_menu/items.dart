import 'package:flutter/material.dart';

import 'pop_menu_options.dart';

class PostsMenuModel {
  String? title;
  PopMenuOptions? options;
  bool? showdivider;
  Color? color;

  PostsMenuModel(
      {this.title, this.options, this.showdivider = false, this.color});

  static List<PostsMenuModel> chatStickers() {
    List<PostsMenuModel> _itemModels = [];
    PostsMenuModel _item = PostsMenuModel(
        title: 'Stickers',
        showdivider: false,
        options: PopMenuOptions.stickers);
    _itemModels.add(_item);
    _item = PostsMenuModel(
        title: 'Photo & video',
        showdivider: false,
        options: PopMenuOptions.photoAndVideo);
    _itemModels.add(_item);
    return _itemModels;
  }
}
