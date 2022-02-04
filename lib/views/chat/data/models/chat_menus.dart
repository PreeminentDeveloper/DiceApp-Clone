import 'package:flutter/material.dart';

enum ChatOptions { copy, delete, block }

class ChatMenu {
  String? title;
  ChatOptions? options;
  Color? color;

  ChatMenu({this.title, this.options, this.color});

  static List<ChatMenu> chatMenu() {
    List<ChatMenu> _itemModels = [];
    ChatMenu _item = ChatMenu(title: 'Copy', options: ChatOptions.copy);
    _itemModels.add(_item);
    _item = ChatMenu(
        title: 'Delete', options: ChatOptions.delete, color: Colors.red);
    _itemModels.add(_item);

    return _itemModels;
  }

  static List<ChatMenu> blocUser({required String? message}) {
    List<ChatMenu> _itemModels = [];
    ChatMenu _item = ChatMenu(title: message, options: ChatOptions.block);
    _itemModels.add(_item);
    return _itemModels;
  }
}
