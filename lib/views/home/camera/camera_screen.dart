import 'package:camera/camera.dart';
import 'package:dice_app/core/navigation/page_router.dart';
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
      final image = await _controller?.takePicture();
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  Widget _cameraWidget() {
    // If the Future is complete, display the preview.
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = _controller!.value.aspectRatio / deviceRatio;
// Modify the yScale if you are in Landscape
    final double yScale = 1;

    return Container(
        child: AspectRatio(
      aspectRatio: deviceRatio,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(xScale / 1.5, yScale, .5),
        child: CameraPreview(_controller!),
      ),
    ));
  }
}
