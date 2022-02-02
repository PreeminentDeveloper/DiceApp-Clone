import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/package/flutter_gallery.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/views/chat/feature_images.dart';
import 'package:dice_app/views/home/camera/widget/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image/image.dart' as img;

import 'widget/bottom_button.dart';

// A screen that allows users to take a picture using a given camera.
class CameraPictureScreen extends StatefulWidget {
  const CameraPictureScreen({
    Key? key,
    this.camera,
    @required this.user,
    @required this.convoID,
  }) : super(key: key);

  final CameraDescription? camera;
  final String? convoID;
  final User? user;

  @override
  CameraPictureScreenState createState() => CameraPictureScreenState();
}

class CameraPictureScreenState extends State<CameraPictureScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> _cameras = [];
  bool _switch = false;

  @override
  void initState() {
    _checkCameraAvailability();
    super.initState();
  }

  _checkCameraAvailability() async {
    // Obtain a list of the available cameras on the device.
    _cameras = await availableCameras();
    setState(() {});
    _initializeCamera(_cameras[0]);
  }

  void _initializeCamera(CameraDescription camera) async {
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _cameraWidget();
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 23.w),
            child: IconButton(
                onPressed: () => _controller!.setFlashMode(FlashMode.off),
                icon: const Icon(Icons.flash_auto, color: DColors.white)),
          ),
          CameraButtongs(
            onClose: () => PageRouter.goBack(context),
            onCapture: () => _takePicture(),
            onSwitch: () => _toggleCamera(),
            onVideoRecord: () => _videoRecord(),
            gallery: () => _pickGallery(),
          )
        ],
      ),
    );
  }

  void _videoRecord() async {
    // Ensure that the camera is initialized.
    await _initializeControllerFuture;
    await _controller?.startVideoRecording();
  }

  /// togle camera
  void _toggleCamera() {
    _switch = !_switch;
    _initializeCamera(_switch ? _cameras[1] : _cameras[0]);
    setState(() {});
  }

  Future<void> _takePicture() async {
// Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      XFile? _file;
      File? _imgFile;

      if (_switch) {
        _imgFile = await _returnIfFrontCamera();
      } else {
        _file = await _controller?.takePicture();
        _imgFile = File(_file!.path);
      }

      setState(() {});

      // Attempt to take a picture and get the file `image`
      // where it was saved.

      PageRouter.gotoWidget(
          DisplayPictureScreen(
              object: ImageObject(
                  path: _imgFile.path,
                  conversationID: widget.convoID,
                  user: widget.user)),
          context);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<File> _returnIfFrontCamera() async {
    XFile? xfile = await _controller?.takePicture();

    List<int>? imageBytes = await xfile?.readAsBytes() ?? [];

    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image fixedImage = img.flipHorizontal(originalImage!);

    File file = File(xfile!.path);

    return await file.writeAsBytes(img.encodeJpg(fixedImage), flush: true);
  }

  Widget _cameraWidget() {
    final size = MediaQuery.of(context).size;

    return Transform.scale(
      scale: _controller!.value.aspectRatio * 9 / 12,
      child: Center(
        child: Container(
            height: size.height,
            alignment: Alignment.center,
            child: Center(child: CameraPreview(_controller!))),
      ),
    );
  }

  List<AssetEntity> results = [];

  _pickGallery() async {
    final _results = await FlutterGallery.pickGallery(
        context: context,
        title: "Dice",
        color: DColors.primaryColor,
        limit: 5,
        maximumFileSize: 100 //Size in megabyte
        );
    setState(() => results = _results);
    final _images = await _convertImages(_results);
    PageRouter.gotoWidget(
        FeatureImages(_images, widget.user?.name ?? '', widget.convoID!),
        context);
  }

  Future<List<File>> _convertImages(List<AssetEntity> results) async {
    List<File> _imageFile = [];
    for (var image in results) {
      final _imageResponse = await callAsyncFetch(image.file);
      _imageFile.add(_imageResponse);
    }
    setState(() {});
    return _imageFile;
  }
}

callAsyncFetch(res) async {
  File image = await res; // image file
  return image;
}
