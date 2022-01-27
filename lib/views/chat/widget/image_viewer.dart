import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:flutter/material.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class ImageViewer extends StatefulWidget {
  final dynamic imageMedia;
  final bool video;
  final bool? isFile;

  const ImageViewer(this.imageMedia,
      {this.isFile = false, this.video = false, Key? key})
      : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  FlickManager? flickManager;

  @override
  void initState() {
    if (widget.video) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.imageMedia),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context,
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => PageRouter.goBack(context),
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.white,
              ))),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(tag: widget.imageMedia, child: _displayWidget()),
      ),
    );
  }

  _displayWidget() {
    if (widget.video) {
      return VisibilityDetector(
        key: ObjectKey(flickManager),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            flickManager?.flickControlManager?.autoPause();
          } else if (visibility.visibleFraction == 1) {
            flickManager?.flickControlManager?.autoResume();
          }
        },
        child: FlickVideoPlayer(
          flickManager: flickManager!,
          flickVideoWithControls: const FlickVideoWithControls(
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen: const FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      );
    }
    if (widget.isFile!) {
      return Image.file(File(widget.imageMedia));
    }
    return ImageLoader(
        width: SizeConfig.getDeviceWidth(context),
        imageLink: widget.imageMedia,
        fit: BoxFit.contain);
  }
}
