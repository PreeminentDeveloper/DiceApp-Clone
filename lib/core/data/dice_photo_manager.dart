import 'dart:io';
import 'dart:math';

import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DicePhotoManager {
  /// Handles image processing
  static Future<File?> pickSingleImage(
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

  static Future<List<PickedFile>?> pickMultipleImages(
      BuildContext context) async {
    try {
      List<PickedFile>? _pickedFile =
          await ImagePicker.platform.pickMultiImage();

      if (_pickedFile != null) {
        return _pickedFile;
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return null;
  }

  static Future<PickedFile?> pickVideos(BuildContext context) async {
    try {
      final _pickedFile =
          await ImagePicker.platform.pickVideo(source: ImageSource.gallery);

      if (_pickedFile != null) {
        return _pickedFile;
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
