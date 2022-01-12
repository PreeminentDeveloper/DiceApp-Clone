import 'dart:convert';

import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ConnectFriends extends StatefulWidget {
  @override
  State<ConnectFriends> createState() => _ConnectFriendsState();
}

class _ConnectFriendsState extends State<ConnectFriends> {
  // AppState appState;

  @override
  void initState() {
    super.initState();
    // appState = Provider.of<AppState>(context, listen: false);
    // getUserInfo();
  }

  // getUserInfo() async {
  //   appState.user = json.decode(await sharedStore.getFromStore("user"));
  //   print(await sharedStore.getFromStore("user"));
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: AppBar(
        backgroundColor: DColors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.sizeLarge!),
              child: TextWidget(
                text: "SKIP",
                appcolor: DColors.actions,
                type: "Objectivity",
                weight: FontWeight.bold,
                size: FontSize.s16,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeLarge!),
                child: TextWidget(
                  text: "Awesome! Finally, \nLet’s connect your friends",
                  type: "Objectivity",
                  weight: FontWeight.w700,
                  size: FontSize.s19,
                  appcolor: DColors.grey,
                  height: 1.2,
                  align: TextAlign.center,
                )),
            SizedBox(height: SizeConfig.sizeXXXL! * 1.4),
            SvgPicture.asset("assets/connect-friend.svg"),
            SizedBox(height: SizeConfig.sizeXXL),
            TextButton(
                onPressed: () {
                  // PageRouter.gotoWidget(InviteContacts(), context);
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(DColors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    elevation: MaterialStateProperty.all(2),
                    shadowColor:
                    MaterialStateProperty.all<Color>(Colors.black87)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: TextWidget(
                    text: "Connect contacts",
                    type: "Objectivity",
                    weight: FontWeight.bold,
                    appcolor: DColors.primaryColor,
                    size: FontSize.s18,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
