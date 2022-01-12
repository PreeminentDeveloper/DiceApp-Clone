import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/invite/invite-contacts.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyFriendsWidget extends StatelessWidget {
  const EmptyFriendsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/add-friend.svg")),
          Container(
            width: double.infinity,
            height: 44,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
                vertical: 20),
            child: TextButton(
                onPressed: () {
                  PageRouter.gotoWidget(InviteContacts(), context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(DColors.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SizeConfig.sizeXXL!),
                      // side: BorderSide(color: Colors.red)
                    ))),
                child: TextWidget(
                  text: "Add Friends",
                  weight: FontWeight.w700,
                  appcolor: DColors.white,
                  size: FontSize.s12,
                )),
          )
        ],
      ),
    );
    ;
  }
}
