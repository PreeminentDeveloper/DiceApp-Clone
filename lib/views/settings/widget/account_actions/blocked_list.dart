import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockedList extends StatefulWidget {
  const BlockedList({Key? key}) : super(key: key);

  @override
  _BlockedListState createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {
  SetUpProvider? _setUpProvider;
  ProfileProvider? _profileProvider;

  @override
  void initState() {
    super.initState();
    _setUpProvider = Provider.of<SetUpProvider>(context, listen: false);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: defaultAppBar(context, title: "Blocked List"),
        ),
        body: Consumer<SetUpProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              GreyContainer(title: "Friends You Have Blocked"),
              const SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.blockedList?.length,
                  itemBuilder: (context, item) {
                    return _item(provider.blockedList![item], removeUser: () {
                      provider.blockedList?.remove(provider.blockedList![item]);
                      setState(() {});
                    });
                  })
            ],
          );
        }));
  }

  Widget _item(user, {removeUser}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.appPadding!),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 15.0,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: user.name,
                size: FontSize.s13,
                weight: FontWeight.w500,
                appcolor: DColors.mildDark,
              ),
              const SizedBox(height: 5),
              TextWidget(
                text: user.username,
                size: FontSize.s10,
                weight: FontWeight.w500,
                appcolor: DColors.lightGrey,
              ),
            ],
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                _setUpProvider?.unblockUser(
                    userID: _profileProvider!.user!.id, receiverID: user.id);
                removeUser();
              },
              style: style,
              child: TextWidget(
                text: "Unblock",
                type: "Objectivity",
                size: FontSize.s10,
                weight: FontWeight.w700,
                appcolor: DColors.primaryAccentColor,
              ))
        ],
      ),
    );
  }

  var style = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: DColors.primaryAccentColor)),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
      minimumSize: MaterialStateProperty.all(const Size(50.57, 21.17)));
}
