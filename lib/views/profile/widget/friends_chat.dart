import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/assets.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/chat/third_party_chat_view.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FriendsChat extends StatelessWidget {
  final String conversationId;
  final User? myFriendProfile;
  const FriendsChat(this.conversationId,
      {required this.myFriendProfile, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Card(
                margin: EdgeInsets.zero,
                elevation: 4,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    side: BorderSide(color: DColors.outputColor, width: 0.3)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...provider.conversationList!
                        .map((conversation) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...conversation.user!
                                    .map(
                                      (user) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.4.w, vertical: 25.h),
                                        child: Row(
                                          children: [
                                            CircleImageHandler(
                                              'https://${user.photo?.hostname}/${user.photo?.url}',
                                              radius: 20,
                                              showInitialText:
                                                  user.photo?.url?.isEmpty ??
                                                      true,
                                              initials: Helpers.getInitials(
                                                  user.name ?? ''),
                                            ),
                                            SizedBox(width: 15.w),
                                            Expanded(
                                                child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: user.name ?? '',
                                                  size: FontSize.s16,
                                                  weight: FontWeight.normal,
                                                  align: TextAlign.left,
                                                  type: "Objectivity",
                                                ),
                                                SizedBox(height: 3.h),
                                                TextWidget(
                                                  text: user.bio ?? '',
                                                  size: FontSize.s12,
                                                  align: TextAlign.left,
                                                  type: "Objectivity",
                                                ),
                                              ],
                                            )),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidget(
                                                  text:
                                                      '${conversation.viewersCount ?? 0}',
                                                  size: FontSize.s12,
                                                  appcolor:
                                                      DColors.primaryColor,
                                                ),
                                                SizedBox(width: 15.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    PageRouter.gotoWidget(
                                                        ThirdPartyChatViewScreen(
                                                          conversation
                                                              .conversationID!,
                                                          viewersCount: conversation
                                                                  .viewersCount ??
                                                              0,
                                                          myFriendProfile:
                                                              myFriendProfile,
                                                          myFriendFriendsProfile:
                                                              user,
                                                        ),
                                                        context,
                                                        animationType:
                                                            PageTransitionType
                                                                .bottomToTop);
                                                  },
                                                  child: SvgPicture.asset(
                                                    Assets.eye,
                                                    color: DColors.primaryColor,
                                                    height: 10.h,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList()
                              ],
                            ))
                        .toList(),
                    // ...provider.conversationList!
                    //     .map((list) =>
                    //         Column(mainAxisSize: MainAxisSize.min, children: [
                    //           ...list.user!
                    //               .map((user) =>
                    //               .toList()
                    //         ]))
                    //     .toList(),

                    SizedBox(height: 11.4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomeDivider(),
                    ),
                    SizedBox(height: 11.4.h),
                  ],
                )),
          ),
        );
      },
    );
  }
}
