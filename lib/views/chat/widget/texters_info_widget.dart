import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final _imageOne =
    "https://images.unsplash.com/photo-1636942099353-f8d8edac22c7?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60";
final _imageTwo =
    "https://images.unsplash.com/photo-1636912305077-eb89d5ede5b3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=774&q=80";

class TextersInfoWidget extends StatelessWidget {
  final Animation<Offset> animation;
  final bool animateValue;
  const TextersInfoWidget(this.animateValue, this.animation, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Align(
        alignment: Alignment.topLeft,
        child: SlideTransition(
          position: animation,
          transformHitTests: true,
          textDirection: TextDirection.ltr,
          child: AnimatedOpacity(
            opacity: animateValue ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(23.r),
                    bottomRight: Radius.circular(23.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Lala\'s chat',
                      appcolor: DColors.faded,
                      size: FontSize.s15,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomeDivider(),
                    // ...MembersMocked.getMembers()
                    ...provider.list!
                        .map((member) => Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleImageHandler(
                                      'https://${member.photo?.hostname}/${member.photo?.url}',
                                      radius: 15.r),
                                  SizedBox(width: 15.w),
                                  Container(
                                    width:
                                        SizeConfig.getDeviceWidth(context) * .4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: member.name ?? '',
                                          appcolor: DColors.mildDark,
                                          size: FontSize.s15,
                                          weight: FontWeight.w500,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3.h),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                                radius: 5.r,
                                                backgroundColor:
                                                    DColors.primaryAccentColor),
                                            // CircleAvatar(
                                            //     radius: 5.r,
                                            //     backgroundColor: member
                                            //             .onlineStatus
                                            //         ? DColors.primaryAccentColor
                                            //         : DColors.sheetColor),
                                            SizedBox(width: 4.w),
                                            TextWidget(
                                              text: "Online",
                                              // member.lastSeen ?? '',
                                              appcolor:
                                                  // member.onlineStatus
                                                  DColors.primaryAccentColor,
                                              // : DColors.sheetColor,
                                              size: FontSize.s11,
                                              weight: FontWeight.normal,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  TextWidget(
                                      text: "@" '',
                                      appcolor: DColors.faded,
                                      size: FontSize.s14,
                                      weight: FontWeight.w400)
                                ],
                              ),
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MembersMocked {
  final String? image;
  final String? name;
  final bool? onlineStatus;
  final String? username;
  final String? lastSeen;

  MembersMocked(
      {this.image, this.name, this.onlineStatus, this.username, this.lastSeen});

  static List<MembersMocked> getMembers() {
    List<MembersMocked> _data = [];
    MembersMocked _member = MembersMocked(
        name: 'Lala Boo',
        username: '@LalaB',
        onlineStatus: true,
        lastSeen: 'Online',
        image: _imageOne);
    _data.add(_member);
    _member = MembersMocked(
        name: 'Maya Baeangelo',
        username: '@MayaB',
        onlineStatus: false,
        lastSeen: 'Last Seen Recently',
        image: _imageTwo);
    _data.add(_member);
    return _data;
  }
}
