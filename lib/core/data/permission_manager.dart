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
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Access to contact data denied')));
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You are restricted from this action')));
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact data not available on device')));
        break;
    }
  }
}