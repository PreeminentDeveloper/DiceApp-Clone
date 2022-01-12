import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/search_people.dart';
import 'package:dice_app/views/invite/provider/invite_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'widget/people.dart';

class FindPeople extends StatefulWidget {
  @override
  _FindPeopleState createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  ProfileProvider? _profileProvider;
  InviteProvider? _inviteProvider;
  int length = 0;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _inviteProvider = Provider.of<InviteProvider>(context, listen: false);
    _loadFriends();
  }

  void _loadFriends() {
    _profileProvider?.getUsersInformations();
    _inviteProvider?.getConnections(pageNumber: 1, id: _profileProvider?.user?.id);

    // inviteBloc.add(MyConnections(pageNo: 1, perPage: 10, userId: appState.user["id"]));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: defaultAppBar(context, title: 'Search'),
      body: Consumer<InviteProvider>(
        builder: (context, inviteProvider, child) {
          if (inviteProvider.inviteEnum == InviteEnum.busy) {
            // return const Center(child: CircularProgressIndicator());
          }
          // if (homeProvider.list!.isEmpty) {
          //   return const EmptyFriendsWidget();
          // }
          return Center(
              child:  Column(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: DColors.inputText,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () {
                        PageRouter.gotoWidget(SearchUsers(), context,
                            animationType: PageTransitionType.fade);
                      },
                      child: Hero(
                        tag: 'search',
                        child: Material(
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Find friends and people",
                                  hintStyle:
                                  TextStyle(color: DColors.lightGrey),
                                  contentPadding: EdgeInsets.all(13),
                                  prefixIcon: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        "assets/search.svg",
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SearchUsers()));
                                    },
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  GreyContainerRow(
                      title: "Friends",
                      length: inviteProvider.inviteEnum == InviteEnum.idle
                          ? _inviteProvider?.list?.length
                          : length),

                  if (inviteProvider.inviteEnum == InviteEnum.busy)
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: const CircularProgressIndicator()
                    ),

                  if (inviteProvider.inviteEnum == InviteEnum.idle)
                    _inviteProvider!.list!.length > 0
                        ? ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _inviteProvider?.list?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var connections = inviteProvider.list?.elementAt(index);
                          return People(
                              connections.name,
                              connections.username,
                              connections.id,
                              connections.photo);
                        })
                        : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: SizeConfig.sizeXXXL!),
                          child: TextWidget(
                            text: "Get adding.\n Level up!",
                            size: FontSize.s20,
                            weight: FontWeight.w500,
                            appcolor: DColors.mildDark,
                          ),
                        ),
                        SvgPicture.asset("assets/empty.svg"),
                      ],
                    )

                  // _item(state.myConnectionEntity.connections),
                ],
              )
          );
        }
      )

    );
  }
}
