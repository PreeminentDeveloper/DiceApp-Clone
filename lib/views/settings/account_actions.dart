import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/settings/provider/setup_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AccountActions extends StatefulWidget {
  const AccountActions({Key? key}) : super(key: key);

  @override
  _AccountActionsState createState() => _AccountActionsState();
}

class _AccountActionsState extends State<AccountActions> {
  var blocked, ignored;
  HomeProvider? _homeProvider;
  SetUpProvider? _setUpProvider;

  var style = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: DColors.primaryAccentColor)),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
      minimumSize: MaterialStateProperty.all(const Size(50.57, 21.17)));

  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _setUpProvider = Provider.of<SetUpProvider>(context, listen: false);
    _setUpProvider?.listIgnoredUsers(
        pageNumber: 1, userID: "087a51cb-0aaf-42eb-8708-eb76bb5ff051");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: DColors.white,
        appBar: defaultAppBar(context, title: 'Account Actions'),
        body: Consumer<SetUpProvider>(builder: (context, provider, child) {
          return (blocked != null && ignored != null)
              ? Column(
                  children: [
                    GreyContainer(title: "Chats and Caches"),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          TextWidget(
                            text: "Cache",
                            weight: FontWeight.w500,
                            appcolor: const Color(0xff333333),
                            size: FontSize.s16,
                            type: "Objectivity",
                          ),
                          SizedBox(width: SizeConfig.sizeXXL),
                          TextWidget(
                            text: "53.56MB",
                            type: "Objectivity",
                            size: FontSize.s14,
                            weight: FontWeight.w700,
                            appcolor: DColors.primaryColor,
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              style: style,
                              child: TextWidget(
                                text: "Clear",
                                type: "Objectivity",
                                size: FontSize.s10,
                                weight: FontWeight.w700,
                                appcolor: DColors.primaryAccentColor,
                              ))
                        ],
                      ),
                    ),
                    _convo(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          TextWidget(
                            text: "Ignored Accounts",
                            weight: FontWeight.w500,
                            appcolor: const Color(0xff333333),
                            size: FontSize.s16,
                            type: "Objectivity",
                          ),
                          SizedBox(width: SizeConfig.sizeXXL),
                          TextWidget(
                            text: ignored.length.toString(),
                            type: "Objectivity",
                            size: FontSize.s14,
                            weight: FontWeight.w700,
                            appcolor: Colors.red,
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => IgnoredList(
                                //             ignored: ignored,
                                //             callback: () {
                                //               setUpBloc.add(ListBlockedUsers(
                                //                   pageNo: 1,
                                //                   perPage: 10,
                                //                   search: "",
                                //                   userId: appState?.id));
                                //             })));
                              },
                              style: style,
                              child: TextWidget(
                                text: "view",
                                type: "Objectivity",
                                size: FontSize.s10,
                                weight: FontWeight.w700,
                                appcolor: DColors.primaryAccentColor,
                              ))
                        ],
                      ),
                    ),
                    GreyContainer(title: "Media and Auto-Download"),
                  ],
                )
              : Container();
        }));
  }

  _convo() {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            TextWidget(
              text: "Conversations",
              weight: FontWeight.w500,
              appcolor: const Color(0xff333333),
              size: FontSize.s16,
              type: "Objectivity",
            ),
            SizedBox(width: SizeConfig.sizeXXL),
            TextWidget(
              text: (_homeProvider?.list?.length.toString()) ?? "",
              type: "Objectivity",
              size: FontSize.s14,
              weight: FontWeight.w700,
              appcolor: DColors.primaryColor,
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  // if (state is HomeLoaded)
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => Conversation(
                  //               data:
                  //                   state.homeEntity.conversationData)));
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
      ),
      GreyContainer(title: "Block list"),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            TextWidget(
              text: "Blocked",
              weight: FontWeight.w500,
              appcolor: const Color(0xff333333),
              size: FontSize.s16,
              type: "Objectivity",
            ),
            SizedBox(width: SizeConfig.sizeXXL),
            TextWidget(
              text: blocked.length.toString(),
              type: "Objectivity",
              size: FontSize.s14,
              weight: FontWeight.w700,
              appcolor: Colors.red,
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => BlockedList(
                  //             blocked: blocked,
                  //             callback: () {
                  //               setUpBloc.add(ListBlockedUsers(
                  //                   pageNo: 1,
                  //                   perPage: 10,
                  //                   search: "",
                  //                   userId: appState?.id));
                  //             }))
                  // );
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
      ),
    ]);
  }
}
