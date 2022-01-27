import 'dart:io';

import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/network/app_config.dart';
import 'package:dice_app/core/network/network_service.dart';
import 'package:dice_app/core/network/url_config.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/widget/date_picker.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/provider/chat_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'data/models/feature_model.dart';
import 'data/models/local_chats_model.dart' as local;
import 'data/models/sending_images.dart';
import 'widget/chat_field.dart';

class FeatureImages extends StatefulWidget {
  final List<File> results;
  final String receiverName;
  final String convoId;
  const FeatureImages(this.results, this.receiverName, this.convoId, {Key? key})
      : super(key: key);

  @override
  State<FeatureImages> createState() => _FeatureImagesState();
}

class _FeatureImagesState extends State<FeatureImages> {
  File? _fileName;
  final _msgController = TextEditingController();
  final List<FeatureModel> _featureModel = [];
  final Map<dynamic, dynamic> _map = <dynamic, dynamic>{};

  @override
  void initState() {
    _convertFileImages();
    super.initState();
  }

  void _convertFileImages() {
    widget.results
        .map((result) =>
            _featureModel.add(FeatureModel(key: result, value: result.path)))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _getCachedValue();
    return Scaffold(
      appBar: defaultAppBar(context,
          titleWidget: TextWidget(
            text: "Feature",
            appcolor: DColors.mildDark,
            weight: FontWeight.w500,
            size: FontSize.s17,
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: TextWidget(
                  text: "Cancel",
                  appcolor: DColors.primaryColor,
                  weight: FontWeight.w500,
                  size: FontSize.s14,
                  onTap: () => _showDialog(),
                ),
              ),
            )
          ]),
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      text: "${widget.results.length} image(s) to...",
                      appcolor: DColors.mildDark,
                      weight: FontWeight.w400,
                      size: FontSize.s12,
                    ),
                    TextWidget(
                      text: widget.receiverName,
                      appcolor: DColors.green700,
                      weight: FontWeight.w600,
                      size: FontSize.s14,
                    )
                  ],
                ),
              ),
              CustomeDivider(thickness: .3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Visibility(
                        visible: _isLoading, child: LinearProgressIndicator()),
                    SizedBox(height: 4.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._featureModel
                              .map((file) => _images(file.key,
                                      selected: _fileName == file.key,
                                      onTap: () {
                                    _fileName = file.key;
                                    setState(() {});
                                  }, removeImage: () {
                                    if (widget.results.length == 1) return;
                                    _featureModel.remove(file);
                                    setState(() {});
                                  }))
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: ChatEditBox(
                onChanged: (value) {
                  _map[_fileName] = value;
                },
                isEnabled: true,
                msgController: _msgController,
                addMessage: () => _pushImage(),
                showGeneralDialog: (value) => null,
                onMenuPressed: (option) => null,
                pickImages: () {},
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _images(data,
      {bool selected = false, Function()? onTap, Function()? removeImage}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    width: 5.w,
                    color:
                        selected ? DColors.primaryColor : Colors.transparent)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(width: 2.5.w, color: DColors.white),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(data,
                    height: 150.h, width: 100.w, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          IconButton(
              onPressed: removeImage,
              icon: Icon(Icons.cancel_outlined, size: 20))
        ],
      ),
    );
  }

  _showDialog() {
    showSheet(context, child: _deleteDialog());
  }

  _deleteDialog() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: TextWidget(
          text: "Discard Draft",
          size: FontSize.s16,
          weight: FontWeight.w400,
          appcolor: DColors.red,
          align: TextAlign.center,
          onTap: () {
            PageRouter.goBack(context);
            PageRouter.goBack(context);
          },
        ),
      ),
    );
  }

  ImageSending? _imageSending;

  final _networkService = NetworkService(baseUrl: UrlConfig.imageUpload);
  List<Medias>? medias = [];
  List<Message>? message = [];
  bool _isLoading = false;

  void _pushImage() async {
    final _user = Provider.of<ProfileProvider>(context, listen: false);

    if (medias!.isNotEmpty) medias!.clear();

    for (int i = 0; i < _featureModel.length; i++) {
      final _feature = _featureModel[i];

      medias?.add(Medias(
        caption: _map[_feature.key],
        filePath: await _copyFileAndreturnNewFilePath(_feature.key),
        file: MultipartFile.fromBytes(_feature.key!.readAsBytesSync(),
            filename: _feature.key!.path.split("/").last,
            contentType:
                MediaType("image", _feature.key!.path.split("/").last)),
        // file: File(_feature.key!.path),
      ));
      setState(() {});
    }
    _imageSending = ImageSending(
        medias: medias,
        message: Message(
            message: '',
            conversationID: widget.convoId,
            userID: _user.user?.id));


    chatDao!.saveSingleChat(
        widget.convoId,
        local.LocalChatModel(
            conversationID: widget.convoId,
            userID: _user.user?.id,
            messageType: 'media',
            insertLocalTime: DateTime.now().toString(),
            imageSending: _imageSending));

    try {
      setState(() => _isLoading = true);
       await _networkService.call('', RequestMethod.upload,
          formData:
              FormData.fromMap(_imageSending!.toJson(addMultipath: true)));
      setState(() => _isLoading = false);
    } catch (e) {
      logger.e(e);
      setState(() => _isLoading = false);
    }
  }

  void _getCachedValue() {
    _msgController.text = _map[_fileName] ?? '';
    _msgController.selection = TextSelection.fromPosition(
        TextPosition(offset: _msgController.text.length));
  }

  Future<String>? _copyFileAndreturnNewFilePath(File? file) async {
    try {
      final _newPath = await Helpers.findLocalPath();
      final _path = await file!.copy("${_newPath.path} filename.jpg");
      return _path.path;
    } catch (e) {
      logger.e(e);
      return '';
    }
  }
}
