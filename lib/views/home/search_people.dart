import 'package:dice_app/core/util/debouncer.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/invite/provider/invite_provider.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'widget/people.dart';

enum WidgetMarker { friend, people }

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.friend;

  ProfileProvider? _profileProvider;
  InviteProvider? _inviteProvider;
  final _debouncer = Debouncer(milliseconds: 900);

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _inviteProvider = Provider.of<InviteProvider>(context, listen: false);
  }

  findFriends(name) {
    _inviteProvider?.findPeople(name: name);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150.0),
            child: AppBar(
              backgroundColor: DColors.white,
              elevation: 1.0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20.0,
                  ),
                  child: Hero(
                    tag: 'search',
                    child: Material(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: DColors.inputText,
                                  borderRadius: BorderRadius.circular(5)),
                              margin: const EdgeInsets.all(30),
                              child: TextFormField(
                                onChanged: (String val) {
                                  _debouncer.run(() => findFriends(val));
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Find friends and people",
                                    hintStyle: const TextStyle(
                                        color: DColors.lightGrey),
                                    contentPadding: const EdgeInsets.all(13),
                                    prefixIcon: GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                          "assets/search.svg",
                                        ),
                                      ),
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (_)=> SeachUsers()));
                                      },
                                    )),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: TextWidget(
                              text: "Cancel",
                              appcolor: DColors.primaryColor,
                              weight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Consumer<InviteProvider>(
              builder: (context, inviteProvider, child) {
            return Column(
              children: [
                _greyTop(),
                if (inviteProvider.inviteEnum == InviteEnum.busy)
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: const CircularProgressIndicator()),
                if (inviteProvider.inviteEnum == InviteEnum.idle)
                  Flexible(
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selectedWidgetMarker != WidgetMarker.friend
                            ? inviteProvider.searchUser.length
                            : inviteProvider.searchUser
                                .where((element) =>
                                    element.connection == "connected")
                                .toList()
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          final people = selectedWidgetMarker !=
                                  WidgetMarker.friend
                              ? inviteProvider.searchUser.elementAt(index)
                              : inviteProvider.searchUser
                                  .where((element) =>
                                      element.connection == "connected")
                                  .toList()
                                  .elementAt(index);
                          // (people.photo["hostname"]);
                          return people.name != null
                              ? People(people)
                              : Container();
                        }),
                  )
              ],
            );
          })),
    );
  }

  Widget _greyTop() {
    return Container(
        color: DColors.bgGrey,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: SizeConfig.sizeXXL! + 5.0,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWidgetMarker = WidgetMarker.friend;
                  });
                },
                child: Container(
                  height: 35,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedWidgetMarker == WidgetMarker.friend
                        ? DColors.white
                        : Colors.transparent,
                    // border: Border(wi),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextWidget(
                    text: "Friends",
                    type: "Objectivity",
                    size: FontSize.s13,
                    weight: FontWeight.w700,
                    appcolor: DColors.lightGrey,
                  ),
                ),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWidgetMarker = WidgetMarker.people;
                  });
                  // findFriends("name");
                },
                child: Container(
                  height: 35,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedWidgetMarker == WidgetMarker.people
                        ? DColors.white
                        : Colors.transparent,
                    // border: Border(wi),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextWidget(
                    text: "People",
                    type: "Objectivity",
                    size: FontSize.s13,
                    weight: FontWeight.w700,
                    appcolor: DColors.lightGrey,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
