import 'dart:io';

import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'bloc/chat_bloc.dart';
import 'data/models/local_chats_model.dart';
import 'data/sources/chat_dao.dart';
import 'provider/chat_provider.dart';
import 'widget/receiver.dart';
import 'widget/sender.dart';
import 'widget/texters_info_widget.dart';
import 'widget/texters_preview.dart';

class ThirdPartyChatViewScreen extends StatefulWidget {
  final String conversationId;
  final User? myFriendProfile;
  final User? myFriendFriendsProfile;
  final int? viewersCount;

  const ThirdPartyChatViewScreen(this.conversationId,
      {required this.myFriendProfile,
      required this.myFriendFriendsProfile,
      required this.viewersCount,
      Key? key})
      : super(key: key);

  @override
  _ThirdPartyChatViewScreenState createState() =>
      _ThirdPartyChatViewScreenState();
}

class _ThirdPartyChatViewScreenState extends State<ThirdPartyChatViewScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  bool _animateValue = false;
  bool _paginate = false;
  ChatProvider? _chatProvider;

  ProfileProvider? _profileProvider;
  HomeProvider? _homeProvider;
  List<LocalChatModel> _localChats = [];
  final ScrollController _scrollController = ScrollController();
  final _bloc = ChatBloc(inject());

  @override
  void initState() {
    _prepareAnimation();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);

    _chatProvider!.loadMessagesFromServer(widget.conversationId);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _ensureThatDbIsoOpened();

    super.initState();
  }

  void _ensureThatDbIsoOpened() async {
    if (chatDao!.getListenable(widget.conversationId) == null) {
      await chatDao!.openABox(widget.conversationId);
    }
    setState(() {});
    _makeCall();
  }

  ///Auto scroll chat to bottom of the list
  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  void _prepareAnimation() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInCubic,
    ));
  }

  void _makeCall() {
    _bloc.add(ListChatEvent(
        pageIndex: 1,
        userID: widget.myFriendProfile?.id,
        conversationID: widget.conversationId));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollDown());
    if (chatDao!.getListenable(widget.conversationId) == null) {
      return Container();
    }
    return Scaffold(
        appBar: defaultAppBar(
          context,
          leading: IconButton(
              onPressed: () => PageRouter.goBack(context),
              icon: const Icon(Icons.arrow_downward,
                  color: DColors.primaryColor)),
          centerTitle: true,
          titleWidget: _customAppBar(
              myFriendProfile: widget.myFriendProfile,
              myFriendFriendsProfile: widget.myFriendFriendsProfile,
              onTap: () {
                setState(() => _animateValue = !_animateValue);
                if (_animateValue) {
                  _controller?.forward();
                } else {
                  _controller?.reverse();
                }
              }), // 702822
        ),
        body: GestureDetector(
          onTap: () {},
          child: BlocListener<ChatBloc, ChatState>(
            bloc: _bloc,
            listener: (context, state) {},
            child: SafeArea(
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable:
                        chatDao!.getListenable(widget.conversationId)!,
                    builder: (BuildContext context, Box<dynamic> value,
                        Widget? child) {
                      final _response = chatDao!.convert(value).toList();
                      return ListView(
                        controller: _scrollController,
                        children: [
                          ...List.generate(_response.length, (index) {
                            final chat = _response[index];

                            return chat.user?.id == widget.myFriendProfile?.id
                                ? SenderSide(
                                    chat: chat, deleteCallback: () => null)
                                : ReceiverSide(
                                    chat: chat, deleteCallback: () => null);
                          }).toList(),
                          SizedBox(
                              height: SizeConfig.getDeviceHeight(context) / 10)
                        ],
                      );
                    },
                  ),
                  TextersInfoWidget(_animateValue, _animation!),
                  _getBottomStackedView(),
                ],
              ),
            ),
          ),
        ));
  }

  callAsyncFetch(res) async {
    File image = await res.file; // image file
    return image;
  }

  Stack _getBottomStackedView() => Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: SizeConfig.getDeviceWidth(context),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: 'Dice Views',
                        appcolor: DColors.black,
                        size: FontSize.s15,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(width: 5.w),
                      SvgPicture.asset(
                        Assets.eye,
                        color: DColors.inputBorderColor,
                        height: 10.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  TextWidget(
                    text: '${widget.viewersCount} Views | 0 Active',
                    appcolor: DColors.black,
                    size: FontSize.s14,
                    weight: FontWeight.normal,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  padding: EdgeInsets.only(right: 38.w),
                  onPressed: () => PageRouter.goBack(context),
                  icon: const Icon(Icons.arrow_downward)),
            ),
          )
        ],
      );

  /// [Note] Here, in other have  images centered appropriately, i had to duplicate the Row widget into 3 replica
  /// Then i turned the left and the right replicate to visibility off so we can be left with the centered Replicate
  // ** ✌️✌️✌️✌️ Hasta Lavista Baby **/
  GestureDetector _customAppBar(
      {required Function() onTap,
      required User? myFriendProfile,
      required User? myFriendFriendsProfile}) {
    return GestureDetector(
      onTap: onTap,
      child: TextersImagePreview(
        myFriendProfile: myFriendProfile,
        myFriendFriendsProfile: myFriendFriendsProfile,
      ),

      // Row(
      //   children: [
      //     Expanded(
      //         flex: 1,
      //         child: Visibility(visible: false, child: TextersImagePreview(userInfo: widget.data))),
      //     Expanded(flex: 3, child: TextersImagePreview()),
      //     Expanded(
      //         flex: 3,
      //         child: Visibility(visible: false, child: TextersImagePreview(userInfo: widget.data))),
      //   ],
      // ),
    );
  }
}
