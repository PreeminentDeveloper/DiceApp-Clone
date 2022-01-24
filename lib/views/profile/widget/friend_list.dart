import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/invite/model/connection_request/connection_request_response.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FriendList extends StatelessWidget {
  final ListData? listData;
  FriendList(this.listData, {Key? key}) : super(key: key);

  ProfileProvider? _profileProvider;
  HomeProvider? _homeProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.all(SizeConfig.appPadding!),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/remove.svg",
            ),
            const SizedBox(width: 20),
            CircleImageHandler(
              'https://${listData?.requester?.photo?.hostname}/${listData?.requester?.photo?.url}',
              showInitialText: listData?.requester?.photo?.url?.isEmpty ?? true,
              initials: Helpers.getInitials(listData?.requester?.name ?? ''),
              radius: 20,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: listData?.requester?.name ?? '',
                  size: FontSize.s16,
                  weight: FontWeight.w500,
                  appcolor: DColors.mildDark,
                ),
                const SizedBox(height: 3),
                TextWidget(
                  text: '@${listData?.requester?.username ?? ''}',
                  size: FontSize.s10,
                  weight: FontWeight.w500,
                  appcolor: DColors.lightGrey,
                ),
              ],
            ),
            const Spacer(),
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
                                    _profileProvider?.ignoreUser(
                                        receiverID: listData?.requester?.id);
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset("assets/remove.svg",
                                      height: 20.h))
                            ],
                          ),
                          content: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      CircleImageHandler(
                                        'https://${listData?.requester?.photo?.hostname}/${listData?.requester?.photo?.url}',
                                        showInitialText: listData?.requester
                                                ?.photo?.url?.isEmpty ??
                                            true,
                                        initials: Helpers.getInitials(
                                            listData?.requester?.name ?? ''),
                                        radius: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text:
                                                listData?.requester?.name ?? '',
                                            size: FontSize.s16,
                                            weight: FontWeight.w500,
                                            appcolor: DColors.mildDark,
                                          ),
                                          const SizedBox(height: 3),
                                          TextWidget(
                                            text:
                                                '@${listData?.requester?.username ?? ''}',
                                            size: FontSize.s10,
                                            weight: FontWeight.w500,
                                            appcolor: DColors.lightGrey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: CustomeDivider()),
                                Row(children: [
                                  SizedBox(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: TextButton(
                                        onPressed: () async {
                                          _profileProvider?.ignoreUser(
                                              receiverID:
                                                  listData?.requester?.id);
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            SizeConfig
                                                                .sizeXXL!),
                                                    side: const BorderSide(
                                                        color: DColors
                                                            .primaryColor)))),
                                        child: TextWidget(
                                          text: "Ignore",
                                          appcolor: DColors.primaryColor,
                                          size: FontSize.s13,
                                          weight: FontWeight.w700,
                                        )),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 35,
                                    width:
                                        MediaQuery.of(context).size.width / 3.2,
                                    child: TextButton(
                                        onPressed: () async {
                                          _profileProvider?.acceptConnection(
                                              homeProvider: _homeProvider,
                                              receiverID:
                                                  listData?.requester?.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
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
                                                    side: const BorderSide(
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
