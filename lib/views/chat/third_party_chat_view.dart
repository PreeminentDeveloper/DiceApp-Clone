import 'dart:io';

import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
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
import 'widget/receiver.dart';
import 'widget/sender.dart';
import 'widget/texters_info_widget.dart';
import 'widget/texters_preview.dart';

class ThirdPartyChatViewScreen extends StatefulWidget {
  final data, id, conversationData;
  ThirdPartyChatViewScreen({this.data, this.id, this.conversationData});

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

  final _chatBloc = ChatBloc(inject());
  ProfileProvider? _profileProvider;
  HomeProvider? _homeProvider;

  List<LocalChatModel> _localChats = [];

  @override
  void initState() {
    _prepareAnimation();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _fetchConversations();
    super.initState();
  }

  void _fetchConversations() {
    _chatBloc.add(ListChatEvent(
        pageIndex: 1,
        userID: _profileProvider?.user?.id,
        conversationID: _homeProvider?.conversationID));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: defaultAppBar(
          context,
          leading: IconButton(
              onPressed: () => PageRouter.goBack(context),
              icon: const Icon(Icons.arrow_downward,
                  color: DColors.primaryColor)),
          titleSpacing: 0,
          centerTitle: true,
          titleWidget: _customAppBar(onTap: () {
            setState(() => _animateValue = !_animateValue);
            if (_animateValue) {
              _controller?.forward();
            } else {
              _controller?.reverse();
            }
          }),
        ),
        body: GestureDetector(
          onTap: () {},
          child: SafeArea(
            child: Stack(
              children: [
                BlocListener<ChatBloc, ChatState>(
                    bloc: _chatBloc,
                    listener: (context, state) async {
                      if (state is ChatLoadingState) {}
                      if (state is ChatSuccessState) {}
                      if (state is ChatFailedState) {}
                    },
                    child: ValueListenableBuilder(
                        valueListenable: chatDao!.getListenable()!,
                        builder: (BuildContext context, Box<dynamic> value,
                            Widget? child) {
                          _localChats = chatDao!.convert(value).toList();

                          return NotificationListener<ScrollEndNotification>(
                            // onNotification: (scrollEnd) {
                            //   final metrics = scrollEnd.metrics;
                            //   if (metrics.atEdge) {
                            //     bool isTop = metrics.pixels == 0;
                            //     if (isTop) {
                            //       _paginate = false;
                            //     } else {
                            //       _paginate = true;
                            //     }
                            //     setState(() {});
                            //   }
                            //   return true;
                            // },
                            child: SingleChildScrollView(
                              key: const PageStorageKey<String>('chat'),
                              child: Column(
                                children: [
                                  SizedBox(height: 22.h),
                                  Row(
                                    children: [
                                      Expanded(child: CustomeDivider()),
                                      TextWidget(
                                        text: 'Today',
                                        type: "Circular",
                                        size: FontSize.s12,
                                        appcolor: DColors.lightGrey,
                                      ),
                                      Expanded(child: CustomeDivider()),
                                    ],
                                  ),
                                  SizedBox(height: 22.h),
                                  ..._localChats
                                      .map((chat) => chat.userID ==
                                              _profileProvider?.user?.id
                                          ? SenderSide(
                                              chat: chat, deleteCallback: () {})
                                          : ReceiverSide(
                                              chat: chat,
                                              deleteCallback: () {}))
                                      .toList(),
                                  SizedBox(height: 40.h)
                                ],
                              ),
                            ),
                          );
                        })),
                TextersInfoWidget(_animateValue, _animation!),
                _getBottomStackedView(),
              ],
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
              width: SizeConfig.getDeviceWidth(context),
              color: DColors.white,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: 'Dice View',
                        appcolor: DColors.black,
                        size: FontSize.s14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(width: 5.w),
                      SvgPicture.asset(
                        Assets.eye,
                        color: DColors.inputBorderColor,
                        height: 15.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // BlocProvider<HomeBloc>(
                  //     create: (context) => homeBloc,
                  //     child: BlocListener<HomeBloc, HomeState>(
                  //         listener: (context, state) async {
                  //       if (state is HomeError) {}
                  //     }, child: BlocBuilder<HomeBloc, HomeState>(
                  //             builder: (context, state) {
                  //       return TextWidget(
                  //         text: state is ConversationViewLoaded
                  //             ? '${state.conversationViewerEntity.totalViewers.toString()} views | 0 active'
                  //             : '0 views | 0 active',
                  //         appcolor: DColors.black,
                  //         size: FontSize.s14,
                  //         weight: FontWeight.normal,
                  //       );
                  //     })))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                padding: EdgeInsets.only(right: 38.w),
                onPressed: () => PageRouter.goBack(context),
                icon: const Icon(Icons.arrow_downward)),
          )
        ],
      );

  /// [Note] Here, in other have  images centered appropriately, i had to duplicate the Row widget into 3 replica
  /// Then i turned the left and the right replicate to visibility off so we can be left with the centered Replicate
  // ** ✌️✌️✌️✌️ Hast Lavista Baby **/
  GestureDetector _customAppBar({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220.w,
        alignment: Alignment.centerLeft,
        // color: Colors.red,
        child: const TextersImagePreview(),
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
