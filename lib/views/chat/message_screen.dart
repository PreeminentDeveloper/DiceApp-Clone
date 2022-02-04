// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/chat_event.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/package/flutter_gallery.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/widget/receiver.dart';
import 'package:dice_app/views/chat/widget/sender.dart';
import 'package:dice_app/views/home/camera/camera_screen.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'bloc/chat_bloc.dart';
import 'data/models/chat_menus.dart';
import 'feature_images.dart';
import 'provider/chat_provider.dart';
import 'stickers_screen.dart';
import 'widget/chat_field.dart';

final bucketGlobal = PageStorageBucket();

class MessageScreen extends StatefulWidget {
  final dynamic user;
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
  final _bloc = ChatBloc(inject());
  int _index = 1;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _chatProvider!.loadMessagesFromServer(widget.conversationID!);
    _chatProvider!.listenToChatEvents(
        widget.conversationID!, _profileProvider!.user!.id!, widget.user!.id!);
    eventBus.on<ChatEventBus>().listen((event) => _scrollDown());
    _profileProvider!.getMyFriendsProfile(widget.user.id);

    _ensureThatDbIsoOpened();
    super.initState();
  }

  void _ensureThatDbIsoOpened() async {
    if (chatDao!.getListenable(widget.conversationID!) == null) {
      await chatDao!.openABox(widget.conversationID!);
    }
    _makeCall();
    setState(() {});
  }

  ///Auto scroll chat to bottom of the list
  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  void _makeCall() {
    _bloc.add(ListChatEvent(
        pageIndex: _index,
        userID: _profileProvider!.user!.id!,
        conversationID: widget.conversationID));
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

              return BlocListener<ChatBloc, ChatState>(
                bloc: _bloc,
                listener: (context, state) {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: GroupedListView<dynamic, String>(
                        elements: _response,
                        sort: false,
                        controller: _scrollController,
                        groupBy: (element) =>
                            TimeUtil.chatDate(element.insertedAt),
                        groupSeparatorBuilder: (String groupByValue) =>
                            _getGroupedTime(groupByValue),
                        indexedItemBuilder: (context, dynamic element,
                                int index) =>
                            element.user?.id == _profileProvider?.user?.id
                                ? SenderSide(
                                    chat: element,
                                    deleteCallback: () => _removeMessage(index))
                                : ReceiverSide(
                                    chat: element,
                                    deleteCallback: () =>
                                        _removeMessage(index)),
                        floatingHeader: true,
                      ),
                    ),
                    SizedBox(height: SizeConfig.getDeviceHeight(context) / 10)
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: widget.user?.iblocked != null
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text('You have blocked this user',
                          style: TextStyle(color: DColors.grey400)))
                  : ChatEditBox(
                      onChanged: (value) => _toggleIcons(value),
                      isEnabled: isEnabled,
                      msgController: _messageController,
                      addMessage: () =>
                          widget.user?.iblocked != null ? null : _addMessage(),
                      showGeneralDialog: (value) =>
                          widget.user?.iblocked != null
                              ? null
                              : _showDialog(value),
                      onMenuPressed: (option) => widget.user?.iblocked != null
                          ? null
                          : _showDialog(''),
                      showStickerDialog: (val) => widget.user?.iblocked != null
                          ? null
                          : _toggleStickerOff(val),
                      toggleSticekrDialog:
                          widget.user?.iblocked != null ? null : _sticker,
                      pickImages: () => widget.user?.iblocked != null
                          ? null
                          : _showDialog(''),
                      takePicture: () => widget.user?.iblocked != null
                          ? null
                          : PageRouter.gotoWidget(
                              CameraPictureScreen(
                                  user: widget.user,
                                  convoID: widget.conversationID),
                              context),
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
    bool? _sent = await _chatProvider!.addMessageToLiveDB(
        _profileProvider!.user!.id!,
        widget.conversationID,
        _messageController.text);
    _messageController.text = '';
    isEnabled = false;

    if (_sent!) {
      Provider.of<HomeProvider>(context, listen: false).listConversations(
          pageNumber: 1, search: '', userID: _profileProvider!.user!.id!);
      _makeCall();
    }
    setState(() {});
  }

  void _removeMessage(int index) {
    chatDao!.removeSingleItem(index);
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
      child: Consumer<ChatProvider>(
        builder: (context, chat, child) {
          return Row(
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
                          backgroundColor: chat.isUserOnline
                              ? DColors.primaryAccentColor
                              : const Color(0xffB2B2B2),
                        ),
                        SizedBox(width: 2.5.h),
                        TextWidget(
                          text: chat.isUserOnline ? 'Online' : "Offline",
                          appcolor: chat.isUserOnline
                              ? DColors.primaryAccentColor
                              : const Color(0xffB2B2B2),
                          weight: FontWeight.w300,
                          size: FontSize.s12,
                        ),
                      ],
                    )
                  ]),
            ],
          );
        },
      ));

  PopMenuWidget _blockUser() => PopMenuWidget(
        primaryWidget: Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.more_horiz, color: DColors.lightGrey)),
        menuItems: ChatMenu.blocUser(
            message: widget.user?.iblocked != null ? 'Unlock' : 'block'),
        menuCallback: (option) {
          widget.user?.iblocked != null
              ? Provider.of<SetUpProvider>(context, listen: false).unblockUser(
                  userID: _profileProvider?.user?.id,
                  receiverID: widget.user?.id)
              : Provider.of<SetUpProvider>(context, listen: false).blockUser(
                  userID: _profileProvider?.user?.id,
                  receiverID: widget.user?.id);
          controller.hideMenu();
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

  Widget _getGroupedTime(String groupByValue) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
      child: Row(
        children: [
          Expanded(child: CustomeDivider(thickness: .3)),
          TextWidget(
            text: TimeUtil.timeAgoSinceDate(groupByValue),
            appcolor: const Color(0xffB2B2B2),
            weight: FontWeight.w500,
            size: 10.sp,
          ),
          Expanded(child: CustomeDivider(thickness: .3)),
        ],
      ),
    );
  }
}

callAsyncFetch(res) async {
  File image = await res; // image file
  return image;
}
