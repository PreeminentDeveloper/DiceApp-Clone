// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dice_app/core/event_bus/event_bus.dart';
import 'package:dice_app/core/event_bus/events/online_event.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/package/flutter_gallery.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/widget/sender.dart';
import 'package:dice_app/views/home/camera/camera_screen.dart';
import 'package:dice_app/views/home/home_screen.dart';
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
import 'package:page_transition/page_transition.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'bloc/chat_bloc.dart';
import 'data/models/chat_menus.dart';
import 'data/models/list_chat_response.dart';
import 'feature_images.dart';
import 'provider/chat_provider.dart';
import 'stickers_screen.dart';
import 'widget/chat_field.dart';
import 'widget/grouped_time.dart';
import 'widget/receiver.dart';

final bucketGlobal = PageStorageBucket();

class MessageScreen extends StatefulWidget {
  final dynamic user;
  final String? conversationID;
  final bool? isFromMedia;
  MessageScreen({this.isFromMedia = false, this.user, this.conversationID});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool _switchView = false;
  bool isEnabled = false;
  List<AssetEntity> results = [];
  ProfileProvider? _profileProvider;
  ChatProvider? _chatProvider;
  HomeProvider? _homeProvider;
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _bloc = ChatBloc(inject());
  int _index = 1;
  bool _isOnline = false;
  List<ListOfMessages> _messages = [];

  @override
  void initState() {
    _initializeValues();
    super.initState();
  }

  void _initializeValues() {
    PageStorage.of(context)!.readState(context, identifier: 'chat');

    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _chatProvider!.loadMessagesFromServer(widget.conversationID!);
    _chatProvider!.listenToChatEvents(
        widget.conversationID!, _profileProvider!.user!.id!, widget.user!.id!);
    eventBus.on().listen((event) {
      if (event is OnlineListener) {
        _isOnline = event.event?['status'] ?? false;
        // setState(() {});
      }
    });
    _profileProvider!.getMyFriendsProfile(widget.user.id);

    _makeCall();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollDown());
    if (chatDao!.getListenable(widget.conversationID!) == null) {
      return Container();
    }
    return Scaffold(
      appBar: defaultAppBar(context,
          titleSpacing: 0,
          centerTitle: false,
          titleWidget: _getTitleWidget(),
          goBack: widget.isFromMedia!
              ? () => PageRouter.gotoWidget(HomeScreen(), context,
                  clearStack: true, animationType: PageTransitionType.fade)
              : () => PageRouter.goBack(context),
          onTap: () => setState(() => _switchView = !_switchView),
          actions: [_blockUser()]),
      body: GestureDetector(
          // onTap: () => _toggleStickerOff(false),
          child:
              SafeArea(child: _switchView ? const StickersView() : _newBody())),
    );
  }

  /// returns body view
  Stack _newBody() => Stack(
        children: [
          PageStorage(
            bucket: bucketGlobal,
            child: BlocListener<ChatBloc, ChatState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  _messages = state.response ?? [];
                  setState(() {});
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GroupedListView<dynamic, String>(
                      key: const PageStorageKey<String>('chat'),
                      elements: _messages,
                      sort: false,
                      controller: _scrollController,
                      groupBy: (element) =>
                          TimeUtil.chatDate(element.insertedAt),
                      groupSeparatorBuilder: (String groupByValue) =>
                          GroupedTimer(groupByValue),
                      indexedItemBuilder:
                          (context, dynamic element, int index) =>
                              element.user?.id == _profileProvider?.user?.id
                                  ? SenderSide(
                                      chat: element,
                                      deleteCallback: () =>
                                          _removeMessage(index, element.id))
                                  : ReceiverSide(
                                      chat: element,
                                      deleteCallback: () =>
                                          _removeMessage(index, element.id)),
                      floatingHeader: true,
                    ),
                  ),
                  SizedBox(height: SizeConfig.getDeviceHeight(context) / 10)
                ],
              ),
            ),
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

  void _removeMessage(int index, String? messageID) {
    _messages.removeAt(index);
    _chatProvider?.removeSingleMessage(
        int.tryParse(messageID!)!, _profileProvider!.user!.id!);
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
        FeatureImages(widget.user, _images, widget.user?.name ?? '',
            widget.conversationID!),
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
                          backgroundColor: _isOnline
                              ? DColors.primaryAccentColor
                              : const Color(0xffB2B2B2),
                        ),
                        SizedBox(width: 2.5.h),
                        TextWidget(
                          text: _isOnline ? 'Online' : "Offline",
                          appcolor: _isOnline
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
          _homeProvider!.listConversations(userID: _profileProvider!.user!.id!);
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
}

callAsyncFetch(res) async {
  File image = await res; // image file
  return image;
}
