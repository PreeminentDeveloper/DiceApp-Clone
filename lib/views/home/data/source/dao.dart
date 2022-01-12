// ignore_for_file: unnecessary_cast

import 'package:dice_app/core/data/hive_manager.dart';
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

  Future<void> myElection() async {
    // final map = {
    //   for (var g in data!) (g as Data).eid.toString(): (g as Data).toJson()
    // };
    // await _box!.putAll(map);
  }

  // List<Data> convert(Box box) {
  //   Map<String, dynamic> raw = Map<String, dynamic>.from(box.toMap());
  //   return raw.values
  //       .map((e) => Data.fromJson(json.decode(json.encode(e))))
  //       .toList();
  // }

  ValueListenable<Box>? getListenable({List<String>? keys}) {
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  Future truncate() async {
    await _box?.clear();
  }
}
