import 'package:flutter/material.dart';

import '../pop_menu_options.dart';

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
        title: 'Photos', showdivider: false, options: PopMenuOptions.photo);
    _itemModels.add(_item);
    _item = PostsMenuModel(
        title: 'Videos', showdivider: false, options: PopMenuOptions.video);
    _itemModels.add(_item);
    return _itemModels;
  }
}
