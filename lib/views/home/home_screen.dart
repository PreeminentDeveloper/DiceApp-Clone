import 'package:dice_app/core/data/permission_manager.dart';
import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/core/util/time_helper.dart';
import 'package:dice_app/views/chat/data/sources/chat_dao.dart';
import 'package:dice_app/views/chat/message_screen.dart';
import 'package:dice_app/views/chat/provider/chat_provider.dart';
import 'package:dice_app/views/home/data/source/dao.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/home/widget/empty_friends_widget.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/profile/my_profile.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/bottom_sheet.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'camera/camera_screen.dart';
import 'data/model/conversation_list.dart';
import 'find_people.dart';
import 'widget/chat_widget.dart';
import 'widget/profile_window.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SlidableController? _slidableController;

  ScrollController _scrollController = ScrollController();
  ScrollController _paginationController = ScrollController();
  bool upDirection = false, flag = false;
  HomeProvider? _homeProvider;
  ProfileProvider? _profileProvider;
  int _pageIndex = 1;

  @override
  void initState() {
    PermissionManager.requestPermission(context);
    phonixManager.initializePhonix();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _initializeController();
    _listConversations();
    super.initState();
  }

  void _initializeController() {
    _scrollController = ScrollController()
      ..addListener(() {
        upDirection = _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse;

        // makes sure we don't call setState too much, but only when it is needed
        if (upDirection != flag) setState(() {});

        flag = upDirection;
      });
  }

  void _listConversations() async {
    _profileProvider?.getUsersInformations();
    _homeProvider?.listConversations(
        pageNumber: _pageIndex,
        search: '',
        userID: _profileProvider!.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: DColors.white,
          appBar: defaultAppBar(context,
              elevation: flag ? 0 : 1,
              leading: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: SvgPicture.asset(Assets.dice)),
              actions: [
                GestureDetector(
                  child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(Assets.diceLogo)),
                  onTap: () => PageRouter.gotoWidget(FindPeople(), context),
                )
              ]),
          body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true,
                    elevation: 1,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Container(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: ProfileWindow(() {
                        PageRouter.gotoWidget(MyProfile(), context);
                      }, value: flag ? false : true),
                    ),
                    bottom: PreferredSize(
                      child: Container(
                        height: _height * 0.055,
                        color: Colors.white,
                        width: SizeConfig.getDeviceWidth(context),
                        padding:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            text: "Chats",
                            size: FontSize.s16,
                            weight: FontWeight.w700,
                            align: TextAlign.left,
                            appcolor: DColors.primaryColor,
                          ),
                        ),
                      ),
                      preferredSize: Size(_width, _height * 0.055),
                    ),
                  )
                ];
              },
              body: FutureBuilder(
                future: listOfConversationsDao?.getListenable(),
                builder: (BuildContext context,
                    AsyncSnapshot<ValueListenable<Box>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return Container();
                  }

                  return ValueListenableBuilder(
                    valueListenable: snapshot.data!,
                    builder: (_, Box<dynamic> value, __) {
                      List<ConversationList>? _conversationList =
                          listOfConversationsDao!
                              .convert(listOfConversationsDao!.box!)
                              .toList();

                      if (_conversationList.isEmpty) {
                        return const EmptyFriendsWidget();
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (_paginationController
                                  .position.userScrollDirection ==
                              ScrollDirection.reverse) {
                            setState(() => _pageIndex++);
                            _homeProvider?.listConversations(
                                pageNumber: _pageIndex,
                                search: '',
                                userID: _profileProvider!.user!.id!);
                          }
                          return true;
                        },
                        child: ListView(
                          controller: _paginationController,
                          children: [
                            CustomeDivider(thickness: .3),
                            SizedBox(height: 8.h),
                            ...List.generate(_conversationList.length, (index) {
                              final conversation = _conversationList[index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...conversation.user!
                                      .map((user) => ChatListWidget(
                                            slideKey: user.id,
                                            chatObject: ChatObject(
                                                image:
                                                    'https://${user.photo?.hostname}/${user.photo?.url}',
                                                name: user.name,
                                                recentMessage: conversation
                                                        .lastMessage?.message ??
                                                    '',
                                                date: TimeUtil.lastTimeMessage(
                                                    conversation.lastMessage
                                                        ?.insertedAt),
                                                viewersCount:
                                                    conversation.viewersCount),
                                            onTapProfile: () =>
                                                PageRouter.gotoWidget(
                                                    OtherProfile(user.id!),
                                                    context),
                                            onPressed: () async {
                                              Provider.of<ChatProvider>(context,
                                                      listen: false)
                                                  .markAllMessageAsRead(
                                                      conversation
                                                          .conversationID!);
                                              chatDao!.openABox(
                                                  conversation.conversationID!);
                                              PageRouter.gotoWidget(
                                                  MessageScreen(
                                                      user: user,
                                                      conversationID:
                                                          conversation
                                                              .conversationID),
                                                  context);
                                            },
                                            onTapDelete: () {
                                              listOfConversationsDao!
                                                  .deleteConvo(index);
                                              setState(() {});
                                              _homeProvider?.removeConversation(
                                                  conversationId: conversation
                                                      .conversationID!,
                                                  userID: _profileProvider!
                                                      .user!.id!);
                                            },
                                            onTapCamera: () async {
                                              PageRouter.gotoWidget(
                                                  CameraPictureScreen(
                                                      user: user,
                                                      convoID: conversation
                                                          .conversationID),
                                                  context);
                                            },
                                          ))
                                      .toList()
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    },
                  );
                },
              ))),
    );
  }

  ///TODO remove from list
  _deleteDialog() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: TextWidget(
          text: "Delete for me",
          size: FontSize.s16,
          weight: FontWeight.w400,
          appcolor: DColors.red,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
