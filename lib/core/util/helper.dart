// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// Handles image processing
  static Future<File>? processImage(ImageSource source) async {
    File? _result;
    try {
      final image = await ImagePicker().getImage(source: source);

      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: image!.path,
          // ratioX: 1.0,
          // ratioY: 1.0,
          maxWidth: 512,
          maxHeight: 512,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

      //Compress the image
      final lastIndex = croppedFile?.path.lastIndexOf(RegExp(r'.jp'));
      final splitted = croppedFile?.path.substring(0, (lastIndex));
      final targetPath =
          "${splitted}_out${croppedFile?.path.substring(lastIndex!)}";
      _result = await FlutterImageCompress.compressAndGetFile(
        croppedFile!.path,
        targetPath,
        quality: 50,
      );
    } catch (e) {
      logger.e('Error occured processing image: $e');
    }
    return _result!;
  }
}
