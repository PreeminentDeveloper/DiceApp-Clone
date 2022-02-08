// ignore_for_file: unnecessary_cast

import 'dart:collection';
import 'dart:convert';

import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/chat/data/models/list_chat_response.dart';

import 'package:dice_app/views/chat/data/models/local_chats_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

ChatDao? chatDao;

class ChatDao {
  Box<Map>? _box;

  Box<Map>? get box => _box;

  ChatDao({String? key});

  Future<void> openABox(String key) async {
    _openBox(key: key).then((value) => _box = value);
  }

  Future<Box<Map>> _openBox({String? key = HiveBoxes.chats}) =>
      HiveBoxes.openBox<Map>(key!);

  Future<void> saveMyChats(String? key, List<ListOfMessages>? list) async {
    /// open hive box for this particular chat
    openABox(key!);

    await truncate();

    final map = {
      for (var g in list!)
        (g as ListOfMessages).id: (g as ListOfMessages).toJson()
    };
    await _box!.putAll(map);
  }

  void saveSingleChat(String key, ListOfMessages? localChatModel) async {
    openABox(key);
    await _box!.add(localChatModel!.toJson());
  }
  

  void removeSingleItem(int index) async {
    await _box!.deleteAt(index);
  }

  List<ListOfMessages> convert(Box box) {
    Map<dynamic, dynamic> raw = Map<dynamic, dynamic>.from(box.toMap());

    List<ListOfMessages> _value = raw.values
        .map((e) => ListOfMessages.fromJson(json.decode(json.encode(e))))
        .toList();

    return _value;
  }

  List<ListOfMessages> _sortedValue(List<ListOfMessages> _value) {
    List<String>? _local = [];
    List<ListOfMessages> _sortedValue = [];

    for (final i in _value) {
      if (i.id != null && i.id!.isNotEmpty && !_local.contains(i.id)) {
        _local.add(i.id!);
        _sortedValue.add(i);
      }
    }

    _sortedValue.sort((a, b) => _formatDateTime(a.insertedAt!)
        .compareTo(_formatDateTime(b.insertedAt!)));

    return _sortedValue;
  }

  DateTime _formatDateTime(String date) {
    return DateTime.parse(date);
  }

  ValueListenable<Box>? getListenable(String key, {List<String>? keys}) {
    openABox(key).then((value) => null);
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  Future truncate() async {
    await _box?.clear();
  }
}

extension RemoveDuplicateValues on List<LocalChatModel> {
  List<LocalChatModel>? get removeDuplicateValues {
    final List<LocalChatModel> values = [...map((e) => e)];
    return [
      ...{...values}
    ];
  }
}
