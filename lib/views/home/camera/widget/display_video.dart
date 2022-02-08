import 'dart:io';

import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/views/chat/feature_images.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ImageObject {
  final String? path;
  final String? conversationID;
  final User? user;

  ImageObject({this.path, this.conversationID, this.user});
}

// A widget that displays the picture taken by the user.
class DisplayVideoScreen extends StatefulWidget {
  final ImageObject? object;

  const DisplayVideoScreen({Key? key, required this.object}) : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.object?.path ?? ''))
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: '', backgroundColor: Colors.black),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : Container(),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: CircleAvatar(
                radius: 33,
                backgroundColor: Colors.black38,
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              PageRouter.gotoWidget(
                  FeatureImages(
                      widget.object?.user,
                      [File(widget.object!.path!)],
                      widget.object?.user?.name ?? '',
                      widget.object?.conversationID ?? '',
                      isVideo: true),
                  context);
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
                margin: EdgeInsets.all(23.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: DColors.primaryColor),
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
