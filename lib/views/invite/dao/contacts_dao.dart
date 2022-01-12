import 'dart:async';
import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:dice_app/core/data/hive_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

ContactDao? contactDao;

class ContactDao {
  Box<Map>? _box;

  Box<Map>? get box => _box;

  ContactDao() {
    openBox().then(
      (value) => _box = value,
    );
  }
  Future<Box<Map>> openBox() {
    return HiveBoxes.openBox<Map>(HiveBoxes.contacts);
  }

  Future<void> saveContacts(Iterable<Contact> contacts) async {
    final map = {for (var g in contacts) (g).identifier: (g).toMap()};
    await _box?.putAll(map);
  }

  Iterable<Contact> convert(Box box) {
    final raw = Map<dynamic, dynamic>.from(box.toMap());
    return raw.values.map((e) => Contact.fromMap(e)).toList();
  }

  ValueListenable<Box<Map>>? getListenable({List<String>? keys}) {
    if (keys == null) {
      return _box?.listenable();
    } else {
      return _box?.listenable(keys: keys);
    }
  }

  Future truncate() async => await _box?.clear();
}
