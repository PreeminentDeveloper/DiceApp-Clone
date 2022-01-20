// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/model/conversation_list.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

ListOfConversationsDao? listOfConversationsDao;

class ListOfConversationsDao {
  Box<Map>? _box;

  Box<Map>? get box => _box;

  ListOfConversationsDao() {
    openBox().then((value) => _box = value);
  }

  Future<Box<Map>> openBox() =>
      HiveBoxes.openBox<Map>(HiveBoxes.listofConversations);

  Future<void> myconversations(List<ConversationList> list) async {
    await truncate();
    final map = {
      for (var g in list)
        (g as ConversationList).id: (g as ConversationList).toMap()
    };
    await _box!.putAll(map);
  }

  List<ConversationList> convert(Box box) {
    Map<String, dynamic> raw = Map<String, dynamic>.from(box.toMap());
    return raw.values.map((e) => ConversationList.fromMap(e)).toList();
  }

  Future<ValueListenable<Box>?>? getListenable({List<String>? keys}) async {
    await openBox();
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  Future truncate() async {
    await _box?.clear();
  }
}
