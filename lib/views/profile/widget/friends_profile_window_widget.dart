import 'package:dice_app/core/entity/users_entity.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import 'photo_hero.dart';

class ProfileInfoWindowWidget extends StatelessWidget {
  final User? getProfile;
  const ProfileInfoWindowWidget(this.getProfile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (getProfile?.photo == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: CircleAvatar(
          radius: 60.0,
          child: TextWidget(
            text: Helpers.getInitials(getProfile?.name ?? ''),
            appcolor: DColors.faded,
            size: FontSize.s20! * 2.5,
          ),
          backgroundColor: const Color(0xffE3E3E3),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        PageRouter.gotoWidget(
            DetailScreen(
                "https://${getProfile?.photo?.hostname}/${getProfile?.photo?.url}"),
            context,
            animationType: PageTransitionType.fade);
      },
      child: Hero(
        tag: "profile-img-tag",
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://${getProfile?.photo?.hostname}/${getProfile?.photo?.url}")),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("assets/back.svg",
                        color: Colors.white)),
                TextWidget(
                  text: "Profile",
                  size: FontSize.s16,
                  weight: FontWeight.w700,
                  type: "Objectivity",
                  appcolor: DColors.white,
                ),
                GestureDetector(
                  onTap: () => null,
                  child: SvgPicture.asset(
                    "assets/add-friend.svg",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}