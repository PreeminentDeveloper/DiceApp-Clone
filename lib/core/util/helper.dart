// ignore_for_file: unnecessary_string_interpolations, invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'dart:math';
import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';

final Logger logger = Logger();

class Helpers {
  static final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: '');

  /// get devices height
  static double getDeviceHeight(BuildContext? context) {
    return MediaQuery.of(context!).size.height;
  }

  /// get devices height
  static double getDeviceWidth(BuildContext? context) {
    return MediaQuery.of(context!).size.width;
  }

  static String moneyFormat(final price) {
    try {
      return '${formatCurrency.format(num.tryParse(price))}';
    } catch (e) {
      return '${formatCurrency.format(num.tryParse('0'))}';
    }
  }

  static String formatDate(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatDate = DateFormat("MMM dd, yyyy").format(_dt);
    String _formatTime = DateFormat("HH:MM a").format(_dt);

    return '$_formatDate at $_formatTime';
  }

  static String formatDate2(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatDate = DateFormat("dd/MM/yyyy").format(_dt);
    String _formatTime = DateFormat("HH:MM").format(_dt);

    return '$_formatTime, $_formatDate';
  }

  static String chatTime(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatTime = DateFormat("hh:mm a").format(_dt);

    return _formatTime;
  }

  static String getInitials(String value) {
    List<String> _values = [];
    try {
      if (value.contains('')) {
        _values = value.split(' ');
        if (_values.length > 1 &&
            _values[0].isNotEmpty &&
            _values[1].isNotEmpty) {
          return '${_values[0][0]}${_values[1][0]}'.toUpperCase();
        } else {
          return '${_values[0].substring(0, 2)}'.toUpperCase();
        }
      }
      return value[0][0].toUpperCase();
    } catch (e) {
      return '';
    }
  }

  /// launch any url
  static void launchURL(String link) async {
    if (Platform.isIOS) {
      if (await canLaunch(link)) {
        await launch(link, forceSafariVC: false);
      } else {
        if (await canLaunch(link)) {
          await launch(link);
        } else {
          throw 'Could not launch $link';
        }
      }
    } else {
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        throw 'Could not launch $link';
      }
    }
  }

  // send message
  static void sendSMStoFriend(String message, String contact) async {
    try {
      await sendSMS(message: message, recipients: [contact]);
    } catch (e) {
      logger.e(e);
    }
  }

  /// Handles image processing
  static Future<File?> processImage(
      BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: source);

      if (pickedFile != null) {
        return await _cropImage(context, pickedFile);
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return null;
  }

  static Future<File?> _cropImage(
      BuildContext context, PickedFile imageFile) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'DiceMessanger',
            toolbarColor: DColors.accentColor,
            toolbarWidgetColor: DColors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'DiceMessanger',
        ));

    final _response = await _compressImageFiles(croppedFile!);
    return _response;
  }

  static Future<File?> _compressImageFiles(File mFile) async {
    final _dir = await _findLocalPath();
    final _targetPath = _dir.absolute.path + "/${_generateKey(15)}.jpg";
    File? _result = await FlutterImageCompress.compressAndGetFile(
        mFile.path, _targetPath,
        quality: 10);
    return _result;
  }

//* getting local path
  static Future<Directory> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!;
  }

//* generate key
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String _generateKey(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
