// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/util/helper.dart';

import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

ChatDao? chatDao;

class ChatDao {
  Box<Map>? _box;

  Box<Map>? get box => _box;

  ChatDao({String? key}) {
    openBox().then((value) => _box = value);
  }

  Future<Box<Map>> openBox({String? key = HiveBoxes.chats}) =>
      HiveBoxes.openBox<Map>(key!);

  Future<void> saveMyChats(String? key, List<LocalChatModel>? list) async {
    /// open hive box for this particular chat
    openBox(key: key);

    await truncate();

    final map = {
      for (var g in list!)
        (g as LocalChatModel).id: (g as LocalChatModel).toMap()
    };
    await _box!.putAll(map);
  }

  void saveSingleChat(String key, LocalChatModel? localChatModel) async {
    openBox(key: key);
    await _box!.add(localChatModel!.toMap());
  }

  List<LocalChatModel> convert(Box box) {
    Map<dynamic, dynamic> raw = Map<dynamic, dynamic>.from(box.toMap());

    List<LocalChatModel> _value = raw.values
        .map((e) => LocalChatModel.fromMap(json.decode(json.encode(e))))
        .toList();

    _value.sort((a, b) => _formatDateTime(a.insertLocalTime!)
        .compareTo(_formatDateTime(b.insertLocalTime!)));

    return _value;
  }

  DateTime _formatDateTime(String date) {
    return DateTime.parse(date);
  }

  ValueListenable<Box>? getListenable({List<String>? keys}) {
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  Future truncate() async {
    await _box?.clear();
  }
}
