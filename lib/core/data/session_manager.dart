import 'dart:convert';

import 'package:dice_app/core/data/hive_manager.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

/// A class for managing sessions, handles saving and retrieving of data
class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> initializeSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String keyAuthToken = 'auth_token';
  static const String keyUserData = 'users_data';
  static const String loginKey = 'login';
  static const String userIdKey = 'userIdKey';
  static const String chatSettings = 'chatSettings';
  static const String privacySettings = 'privacySettings';
  static const String notificationSettings = 'notificationSettings';

  String get authToken => sharedPreferences!.getString(keyAuthToken) ?? '';

  int get userId => sharedPreferences!.getInt(userIdKey) ?? 0;

  bool get authLogging => sharedPreferences!.getBool(loginKey) ?? false;

  set authLogging(bool logging) =>
      sharedPreferences!.setBool(loginKey, logging);

  set authToken(String? authToken) =>
      sharedPreferences!.setString(keyAuthToken, authToken!);

  set userId(int userId) => sharedPreferences!.setInt(userIdKey, userId);

  Map<String, dynamic> get usersData =>
      json.decode(sharedPreferences!.getString(keyUserData) ?? '');

  set usersData(Map<String, dynamic> map) =>
      sharedPreferences!.setString(keyUserData, json.encode(map));

  set usersChatSettings(Map<String, dynamic> map) =>
      sharedPreferences!.setString(chatSettings, json.encode(map));

  set usersPrivacySettings(Map<String, dynamic> map) =>
      sharedPreferences!.setString(privacySettings, json.encode(map));

  set usersNotificationSettings(Map<String, dynamic> map) =>
      sharedPreferences!.setString(notificationSettings, json.encode(map));

  Map<String, dynamic> get usersChatSettings =>
      json.decode(sharedPreferences!.getString(chatSettings) ?? '');

  Map<String, dynamic> get usersPrivacySettings =>
      json.decode(sharedPreferences!.getString(privacySettings) ?? '');

  Map<String, dynamic> get usersNotificationSettings =>
      json.decode(sharedPreferences!.getString(notificationSettings) ?? '');

  Future<bool> logOut() async {
    await HiveBoxes.clearAllBox();
    await sharedPreferences!.clear();
    try {
      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      final appDir = await getApplicationSupportDirectory();
      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
      }
    } catch (e) {
      logger.d("error clearing cache");
    }
    return true;
  }
}
