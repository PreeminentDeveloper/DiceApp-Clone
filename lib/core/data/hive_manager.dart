import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/views/home/data/source/dao.dart';
import 'package:dice_app/views/invite/dao/contacts_dao.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  HiveManager._internal();

  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;

  static HiveManager get instance => _instance;

  /// initialize local data storage
  Future<void> initializeDatabase() async {
    await Hive.initFlutter();
    await HiveBoxes.openAllBox();
  }
}

class HiveBoxes {
  static const listofConversations = 'listofConversations';
  static const contacts = 'contacts';

  static Future openAllBox() async {
    listOfConversationsDao = ListOfConversationsDao();
    contactDao = ContactDao();
  }

  static Future clearAllBox() async {
    await listOfConversationsDao?.truncate();
    await contactDao?.truncate();
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    Box<T> box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      try {
        box = await Hive.openBox<T>(boxName);
      } catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
        box = await Hive.openBox<T>(boxName);
      }
    }

    return box;
  }

  static Future<void> closeBox<T>(String boxName) async {
    Box box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
      box.close();
    }
  }

  static Future<void> clearData() async {
    await _clearBox<Map<String, dynamic>>('');
  }

  static Future<void> _clearBox<T>(String name) async {
    try {
      final Box<T> _box = await openBox<T>(name);
      await _box.clear();
    } catch (_) {
      logger.e('clear $name error: ${_.toString()}');
    }
  }

  static logOut(BuildContext context) async {}
}
