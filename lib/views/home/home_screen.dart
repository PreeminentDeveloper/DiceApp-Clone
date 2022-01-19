import 'package:dice_app/core/data/permission_manager.dart';
import 'package:dice_app/core/data/phonix_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/message_screen.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:phoenix_socket/phoenix_socket.dart';

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
  bool upDirection = false, flag = false;
  HomeProvider? _homeProvider;
  ProfileProvider? _profileProvider;

  @override
  void initState() {
    PermissionManager.requestPermission(context);
    phonixManager.initializePhonix();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _initializeController();
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
        pageNumber: 1, search: '', userID: _profileProvider!.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    _listConversations();
    return Scaffold(
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
                  backgroundColor: Colors.transparent,
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
                    !snapshot.hasData) {
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

                    return ListView(
                      children: [
                        CustomeDivider(thickness: .3),
                        SizedBox(height: 8.h),
                        ..._conversationList
                            .map((conversation) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...conversation.user!
                                        .map((user) => ChatListWidget(
                                              slideKey: user.id,
                                              chatObject: ChatObject(
                                                  image:
                                                      'https://${user.photo?.hostname}/${user.photo?.url}',
                                                  name: user.name,
                                                  recentMessage:
                                                      '@${user.username}',
                                                  date: 'timeAgo'),
                                              onTapProfile: () =>
                                                  PageRouter.gotoWidget(
                                                      OtherProfile(user.id!),
                                                      context),
                                              onPressed: () {
                                                PageRouter.gotoWidget(
                                                    MessageScreen(
                                                        user: user,
                                                        conversationID:
                                                            conversation
                                                                .conversationID),
                                                    context);
                                              },
                                              onTapDelete: () => showSheet(
                                                  context,
                                                  child: _deleteDialog()),
                                              onTapCamera: () async {
                                                PageRouter.gotoWidget(
                                                    CameraPictureScreen(),
                                                    context);
                                              },
                                            ))
                                        .toList()
                                  ],
                                ))
                            .toList(),
                      ],
                    );
                  },
                );
              },
            )));
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
