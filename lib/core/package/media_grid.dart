// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/provider/chat_provider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'media_option.dart';
import 'widget/gallery_custom_appbar.dart';

class MediaGrid extends StatefulWidget {
  final ValueChanged<List<AssetEntity>>? onItemsSelected;
  final String? title;
  final Color? color;
  final int? limit;
  int? maximumFileSize;
  MediaGrid(
      {this.onItemsSelected,
      this.title,
      this.color,
      this.limit,
      this.maximumFileSize});

  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  List<MediaOption>? allMedia = [];
  List<MediaOption>? selectedMedia = [];
  int? currentPage = 0;
  int? selectedMediaCount = 0;
  int? lastPage;

  bool isFetching = false;
  bool loadedInitial = false;

  List<MediaAlbum> allAlbums = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (allMedia!.isEmpty && !loadedInitial) {
      _fetchNewMedia();
      loadedInitial = true;
    }
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    setState(() => isFetching = true);

    lastPage = currentPage;
    var result = await PhotoManager.requestPermission();

    if (result) {
      // GET ALBUMS
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      allAlbums.addAll(
        albums.map((e) => MediaAlbum(
              assetCount: e.assetCount,
              name: Platform.isIOS ? e.name : e.name,
            )),
      );

      List<AssetEntity> media = albums.length > 0
          ? await albums[0].getAssetListPaged(currentPage!, 60)
          : [];

      for (var asset in media) {
        final thumb = await asset.thumbDataWithSize(200, 200);
        final mediaOption = MediaOption(asset: asset, thumb: thumb);

        allMedia!.add(mediaOption);
      }

      setState(() {
        currentPage = currentPage! + 1;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }

  String _showDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return twoDigits(duration.inHours) != '00'
        ? "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds"
        : twoDigitMinutes != '00'
            ? "$twoDigitMinutes:$twoDigitSeconds"
            : "0:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    selectedMediaCount = 0;
    if (isFetching && allMedia!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: [
          const GalleryCustomAppBar(),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                return _handleScrollEvent(scroll);
              },
              child: GridView.builder(
                  itemCount: allMedia!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (BuildContext context, int index) {
                    int selectedPosition = 0;
                    if (selectedMedia!.contains(allMedia![index])) {
                      selectedMediaCount = selectedMediaCount! + 1;
                      selectedPosition = selectedMediaCount!;
                    }

                    return Consumer<ChatProvider>(
                      builder: (context, mediaType, child) {
                        return Visibility(
                          visible: allMedia![index].asset!.type ==
                              mediaType.assetType,
                          child: mediaItem(allMedia![index],
                              selectedPosition: selectedPosition),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: selectedMedia!.isNotEmpty,
        child: FloatingActionButton(
          backgroundColor: DColors.primaryAccentColor,
          onPressed: () => widget
              .onItemsSelected!(selectedMedia!.map((e) => e.asset!).toList()),
          child: const Icon(Icons.check),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: "Stickers",
              appcolor: DColors.primaryAccentColor,
              weight: FontWeight.w500,
              size: FontSize.s18,
            ),
            TextWidget(
              text: "More Apps",
              appcolor: DColors.primaryAccentColor,
              weight: FontWeight.w500,
              size: FontSize.s18,
            ),
          ],
        ),
      ),
    );
  }

  Widget mediaItem(MediaOption? media, {int? selectedPosition}) {
    return InkWell(
      onTap: () async {
        final _f = await media!.asset!.file;

        double size = await formatBytes(_f!);
        setState(() {
          if (selectedMedia!.contains(media)) {
            selectedMedia!.remove(media);
          } else {
            if (widget.maximumFileSize != null &&
                size > (widget.maximumFileSize ?? 0)) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content:
                    Text("Maximum file size of ${widget.maximumFileSize ?? 0}"),
              ));
            } else if (selectedMedia!.length < widget.limit!) {
              selectedMedia!.add(media);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Maximum of ${widget.limit}"),
              ));
            }
          }
        });
      },
      child: Stack(
        children: <Widget>[
          Stack(
            key: ValueKey(media!.asset?.id),
            children: <Widget>[
              Positioned.fill(
                child: Image.memory(
                  media.thumb,
                  fit: BoxFit.cover,
                ),
              ),
              media.asset?.type == AssetType.video
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                        child: Text(
                          _showDuration(media.asset!.videoDuration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          selectedMedia!.contains(media)
              ? Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Container(
                      color: Colors.white54,
                    )),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.check_circle,
                            color: DColors.primaryColor),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Future<double> formatBytes(File file) async {
    int bytes = file.lengthSync();
    if (bytes <= 0) return 0;
    return bytes / 1048576;
  }
}
