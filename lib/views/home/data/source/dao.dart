// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
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

  Future<void> myconversations(List<User>? list) async {
    final map = {for (var g in list!) (g as User).id: (g as User).toJson()};
    await _box!.putAll(map);
  }

  List<User> convert(Box box) {
    Map<String, dynamic> raw = Map<String, dynamic>.from(box.toMap());
    return raw.values
        .map((e) => User.fromJson(json.decode(json.encode(e))))
        .toList();
  }

  ValueListenable<Box>? getListenable({List<String>? keys}) {
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  

  Future truncate() async {
    await _box?.clear();
  }
}
