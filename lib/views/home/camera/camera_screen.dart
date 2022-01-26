import 'package:camera/camera.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:flutter/material.dart';

import 'widget/bottom_button.dart';

// A screen that allows users to take a picture using a given camera.
class CameraPictureScreen extends StatefulWidget {
  const CameraPictureScreen({
    Key? key,
    @required this.camera,
  }) : super(key: key);

  final CameraDescription? camera;

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
          //      Align(x
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: 120,
          //     width: double.infinity,
          //     padding: EdgeInsets.all(15),
          //     color: Colors.black,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: <Widget>[
          //         _cameraToggleRowWidget(),
          //         _cameraControlWidget(context),
          //         Spacer()
          //       ],
          //     ),
          //   ),
          // ),
          CameraButtongs(
            onClose: () => PageRouter.goBack(context),
            onCapture: () => _takePicture(),
            onSwitch: () => _toggleCamera(),
            onVideoRecord: () => _videoRecord(),
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

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final _image = await _controller?.takePicture();
      logger.d(_image);
    } catch (e) {
      logger.e(e);
    }
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
}
