import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

TextEditingController _about = TextEditingController();

class AboutModal extends StatelessWidget {
  const AboutModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProfileProvider>(context, listen: false);
    _about.text = _provider.user?.bio ?? '';
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r)),
            color: Colors.white),
        padding: EdgeInsets.all(SizeConfig.sizeLarge!),
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeSmall!),
                  child: TextWidget(
                    text: "About you",
                    appcolor: DColors.lightGrey,
                    weight: FontWeight.w700,
                    type: "Objectivity",
                    size: FontSize.s16,
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 6 * 25.0,
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    maxLines: 6,
                    controller: _about,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "About you...",
                      fillColor: DColors.bgGrey,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 44,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 6,
                      vertical: 20),
                  child: TextButton(
                      onPressed: () {
                        if (_about.text.isNotEmpty) {
                          _provider.updateUsersInfo(
                              context, "bio", _about.text);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              DColors.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.sizeXXL!),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: TextWidget(
                        text: profile.profileEnum == ProfileEnum.busy
                            ? "Updating..."
                            : "Done".toUpperCase(),
                        weight: FontWeight.w700,
                        appcolor: DColors.white,
                        size: FontSize.s12,
                      )),
                ),
              ],
            );
          },
        ));
  }
}
