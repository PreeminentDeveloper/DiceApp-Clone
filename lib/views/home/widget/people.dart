import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/invite/model/my_connections/my_connections_response.dart';
import 'package:dice_app/views/profile/friends_profile.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class People extends StatelessWidget {
  final ListOfData? connection;
  const People(this.connection);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.appPadding!),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  connections?.name,
          //                     connections?.username,
          //                     connections?.id,
          //                     connections?.photo
          CircleImageHandler(
            'https://${connection?.photo?.hostname}/${connection?.photo?.url}',
            radius: 20.r,
            showInitialText: connection?.photo?.url?.isEmpty ?? true,
            initials: Helpers.getInitials(connection?.name ?? ''),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: connection?.name ?? '',
                  size: FontSize.s16,
                  weight: FontWeight.w500,
                  appcolor: DColors.mildDark,
                ),
                const SizedBox(height: 5),
                TextWidget(
                  text: '@${connection?.username ?? ''}',
                  size: FontSize.s10,
                  weight: FontWeight.w500,
                  appcolor: DColors.lightGrey,
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OtherProfile(connection!.id!)));
              },
              child: SvgPicture.asset("assets/arrow-forward.svg")),
        ],
      ),
    );
  }
}
