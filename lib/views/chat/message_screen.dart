// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/event_bus/events/online_event.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/package/flutter_gallery.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/bloc/chat_bloc.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/widget/receiver.dart';
import 'package:dice_app/views/chat/widget/sender.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'data/models/chat_menus.dart';
import 'data/models/local_chats_model.dart';
import 'feature_images.dart';
import 'provider/chat_provider.dart';
import 'stickers_screen.dart';
import 'widget/chat_field.dart';

final bucketGlobal = PageStorageBucket();

class MessageScreen extends StatefulWidget {
  final User? user;
  final String? conversationID;
  MessageScreen({this.user, this.conversationID});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _switchView = false;
  bool isEnabled = false;
  List<AssetEntity> results = [];
  ProfileProvider? _profileProvider;
  ChatProvider? _chatProvider;
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _chatProvider!.loadCachedMessages(widget.conversationID!);
    _chatProvider!.listenToChatEvents(
        widget.conversationID!, _profileProvider!.user!.id!);
    eventBus.on<ChatEventBus>().listen((event) => _scrollDown());
    _ensureThatDbIsoOpened();
    super.initState();
  }

  void _ensureThatDbIsoOpened() async {
    if (chatDao!.getListenable(widget.conversationID!) == null) {
      await chatDao!.openABox(widget.conversationID!);
    }
    setState(() {});
  }

  ///Auto scroll chat to bottom of the list
  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollDown());
    if (chatDao!.getListenable(widget.conversationID!) == null) {
      return Container();
    }
    return PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
        appBar: defaultAppBar(context,
            titleSpacing: 0,
            centerTitle: false,
            titleWidget: _getTitleWidget(),
            onTap: () => setState(() => _switchView = !_switchView),
            actions: [_blockUser()]),
        body: GestureDetector(
            onTap: () => _toggleStickerOff(false),
            child: SafeArea(
                child: _switchView ? const StickersView() : _bodyView())),
      ),
    );
  }

  /// returns body view
  Stack _bodyView() => Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: chatDao!.getListenable(widget.conversationID!)!,
            builder: (BuildContext context, Box<dynamic> value, Widget? child) {
              final _response = chatDao!.convert(value).toList();
              return ListView(
                controller: _scrollController,
                children: [
                  ..._response
                      .map((chat) => chat.userID == _profileProvider?.user?.id
                          ? SenderSide(chat: chat, deleteCallback: () {})
                          : ReceiverSide(chat: chat, deleteCallback: () {}))
                      .toList(),
                  SizedBox(height: SizeConfig.getDeviceHeight(context) / 10)
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: ChatEditBox(
                onChanged: (value) => _toggleIcons(value),
                isEnabled: isEnabled,
                msgController: _messageController,
                addMessage: () => _addMessage(),
                showGeneralDialog: (value) => _showDialog(value),
                onMenuPressed: (option) => _showDialog(''),
                showStickerDialog: (val) => _toggleStickerOff(val),
                toggleSticekrDialog: _sticker,
                pickImages: () => _showDialog(''),
              ),
            ),
          )
        ],
      );

  bool _sticker = false;

  void _toggleStickerOff(bool val) {
    setState(() => _sticker = val);
    FocusScope.of(context).unfocus();
  }

  void _addMessage() async {
    await _chatProvider!.addMessageToLiveDB(_profileProvider!.user!.id!,
        widget.conversationID, _messageController.text);
    _messageController.text = '';
    setState(() {});
  }

  void _toggleIcons(String value) {
    if (value.isNotEmpty) {
      isEnabled = true;
    } else {
      isEnabled = false;
    }
    setState(() {});
  }

  _showDialog(String value) async {
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
        FeatureImages(_images, widget.user?.name ?? '', widget.conversationID!),
        context);
  }

  Widget _getTitleWidget() => GestureDetector(
        onTap: () =>
            PageRouter.gotoWidget(OtherProfile(widget.user!.id!), context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleImageHandler(
              'https://${widget.user?.photo?.hostname}/${widget.user?.photo?.url}',
              radius: 20,
              showInitialText: widget.user?.photo?.url?.isEmpty ?? true,
              initials: Helpers.getInitials(widget.user?.name ?? ''),
            ),
            SizedBox(width: 10.w),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    text: widget.user?.name ?? '',
                    appcolor: DColors.mildDark,
                    weight: FontWeight.w500,
                    size: FontSize.s17,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 4.r,
                        backgroundColor: DColors.primaryAccentColor,
                      ),
                      SizedBox(width: 2.5.h),
                      TextWidget(
                        text: "Offline",
                        appcolor: DColors.primaryAccentColor,
                        weight: FontWeight.w500,
                        size: FontSize.s12,
                      ),
                    ],
                  )
                ]),
          ],
        ),
      );

  PopMenuWidget _blockUser() => PopMenuWidget(
        primaryWidget: Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.more_horiz, color: DColors.lightGrey)),
        menuItems: ChatMenu.blocUser(),
        menuCallback: (option) {
          // controller.hideMenu();
        },
      );

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
