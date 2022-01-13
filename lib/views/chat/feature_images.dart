import 'dart:convert';
import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/widget/date_picker.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'widget/chat_field.dart';

class FeatureImages extends StatefulWidget {
  final List<File> results;
  final String receiverName;
  final String userId;
  final String convoId;
  const FeatureImages(
      this.results, this.receiverName, this.userId, this.convoId,
      {Key? key})
      : super(key: key);

  @override
  State<FeatureImages> createState() => _FeatureImagesState();
}

class _FeatureImagesState extends State<FeatureImages> {
  String _fileName = '';
  final _msgController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      text: "${widget.results?.length} image(s) to...",
                      appcolor: DColors.mildDark,
                      weight: FontWeight.w400,
                      size: FontSize.s12,
                    ),
                    TextWidget(
                      text: "${widget.receiverName}",
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.results
                          .map((file) => _images(file,
                              selected: _fileName == file.path,
                              onTap: () =>
                                  setState(() => _fileName = file.path),
                              removeImage: () {
                                if (widget.results.length == 1) return;
                                widget.results.remove(file);
                                setState(() {});
                              }))
                          .toList(),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: ChatEditBox(
                onChanged: (value) {},
                isEnabled: true,
                msgController: _msgController,
                addMessage: () => pushImage(),
                showGeneralDialog: (value) => null,
                onMenuPressed: (option) => null,
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

  pushImage() async {
    // var token = await sharedStore.getFromStore("token".toString());

    // var request = http.MultipartRequest(
    //     'POST', Uri.parse("http://35.175.175.194/messages"));

    // //Header....
    // request.headers['Authorization'] = 'Bearer ' + json.decode(token);
    // request.fields['message[message]'] = _msgController.text;
    // request.fields['medias[0][caption]'] = _msgController.text;
    // request.fields['message[conversation_id]'] = widget.convoId;
    // request.fields['message[user_id]'] = widget.userId;
    // request.files
    //     .add(await http.MultipartFile.fromPath('medias[0][file]', _fileName));
    // var response = await request.send();
    // print(response.stream);
    // print(response.statusCode);
    // final res = await http.Response.fromStream(response);
    // print(res.body);
    // if (response.statusCode == 201) {
    //   _msgController.clear();
    // }
  }
}
