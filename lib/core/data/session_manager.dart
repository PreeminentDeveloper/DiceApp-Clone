import 'dart:convert';

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
  static const String receiptStatus = 'receiptStatus';
  static const String onlineStatus = 'onlineStatus';
  static const String pushNotificationStatus = 'pushNotificationStatus';
  static const String who = 'who';
  static const String private = 'private';

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

  set showReceipt(bool receipt) =>
      sharedPreferences!.setBool(receiptStatus, receipt);

  set showOnlineStatus(bool online) =>
      sharedPreferences!.setBool(onlineStatus, online);
  set pushNotification(bool pn) =>
      sharedPreferences!.setBool(pushNotificationStatus, pn);

  set whoCanContactMe(bool pn) => sharedPreferences!.setBool(who, pn);
  set makeAccountPrivate(bool pn) => sharedPreferences!.setBool(private, pn);

  bool get showReceipt => sharedPreferences!.getBool(receiptStatus) ?? true;
  bool get showOnlineStatus => sharedPreferences!.getBool(onlineStatus) ?? true;
  bool get pushNotification =>
      sharedPreferences!.getBool(pushNotificationStatus) ?? true;

  bool get whoCanContactMe => sharedPreferences!.getBool(who) ?? true;
  bool get makeAccountPrivate => sharedPreferences!.getBool(private) ?? true;

  Future<bool> logOut() async {
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
