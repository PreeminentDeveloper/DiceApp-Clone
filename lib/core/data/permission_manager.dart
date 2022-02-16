import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// checks for users permission
  static Future<PermissionStatus> _requestPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  /// returns true if status is granted
  static Future<bool> requestPermission(BuildContext context) async {
    final _status = await _requestPermission();
    if (_status != PermissionStatus.granted) {
      _handleInvalidPermissions(context, _status);
      return false;
    }
    return true;
  }

  static void _handleInvalidPermissions(
      BuildContext context, PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.granted:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        AppSettings.openAppSettings();
        break;
    }
  }
}
