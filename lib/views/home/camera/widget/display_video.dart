import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/views/chat/feature_images.dart';
import 'package:dice_app/views/home/data/model/media_model.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

// A widget that displays the picture taken by the user.
class DisplayVideoScreen extends StatefulWidget {
  final MediaObject? object;

  DisplayVideoScreen({Key? key, required this.object}) : super(key: key);

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialLoad();
    videoController = VideoPlayerController.file(File(widget.object!.path!));
  }

  initialLoad() async {
    await videoController?.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: ''),
      body: Stack(
        children: [
          // VideoPlayer(
          //   File(widget.object!.path!),
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          VideoPlayer(videoController!),
          GestureDetector(
            onTap: () {
              PageRouter.gotoWidget(
                  FeatureImages(
                      [File(widget.object!.path!)],
                      widget.object?.user?.name ?? '',
                      widget.object?.conversationID ?? ''),
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
