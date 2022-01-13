import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FriendList extends StatelessWidget {
  final String text, subText, personId;
  FriendList(this.text, this.subText, this.personId);

  ProfileProvider? _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.all(SizeConfig.appPadding!),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/remove.svg",
            ),
            SizedBox(width: 20),
            CircleAvatar(
                // radius: 15.0,
                ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: text,
                  size: FontSize.s16,
                  weight: FontWeight.w500,
                  appcolor: DColors.mildDark,
                ),
                SizedBox(height: 3),
                TextWidget(
                  text: "@" + subText,
                  size: FontSize.s10,
                  weight: FontWeight.w500,
                  appcolor: DColors.lightGrey,
                ),
              ],
            ),
            Spacer(),
            // GestureDetector(
            //     onTap: (){
            //       Navigator.push(context, MaterialPageRoute(builder: (_)=> OtherProfile(personId)));
            //     },
            //     child: SvgPicture.asset("assets/arrow-forward.svg")
            // ),

            TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> OtherProfile(personId)));

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: "Friend Request",
                                weight: FontWeight.bold,
                                size: FontSize.s14,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset("assets/remove.svg"))
                            ],
                          ),
                          content: Container(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: text,
                                            size: FontSize.s16,
                                            weight: FontWeight.w500,
                                            appcolor: DColors.mildDark,
                                          ),
                                          SizedBox(height: 3),
                                          TextWidget(
                                            text: "@" + subText,
                                            size: FontSize.s10,
                                            weight: FontWeight.w500,
                                            appcolor: DColors.lightGrey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: CustomeDivider()),
                                Row(children: [
                                  Container(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: TextButton(
                                        onPressed: () async {
                                          // otherProfileBloc.add(IgnoreAUser(
                                          //     userId: myId,
                                          //     blockedId: personId));
                                          // Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            SizeConfig
                                                                .sizeXXL!),
                                                    side: BorderSide(
                                                        color: DColors
                                                            .primaryColor)))),
                                        child: TextWidget(
                                          text: "Ignore",
                                          appcolor: DColors.primaryColor,
                                          size: FontSize.s13,
                                          weight: FontWeight.w700,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: TextButton(
                                        onPressed: () async {
                                          // otherProfileBloc.add(AcceptConnection(
                                          //     id: personId,
                                          //     message: "",
                                          //     requesterId: myId));
                                          // Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    DColors.primaryColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        SizeConfig.sizeXXL!),
                                                    side: BorderSide(
                                                        color: DColors
                                                            .primaryColor)))),
                                        child: TextWidget(
                                          text: "Accept",
                                          appcolor: DColors.white,
                                          size: FontSize.s13,
                                          weight: FontWeight.w700,
                                        )),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          actions: [],
                        );
                      });
                },
                style: style,
                child: TextWidget(
                  text: "View",
                  type: "Objectivity",
                  size: FontSize.s10,
                  weight: FontWeight.w700,
                  appcolor: DColors.primaryAccentColor,
                ))
          ],
        ),
      );
    });
  }
}
