import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteWindow extends StatelessWidget {
  final Function()? justFollow;
  final Function(String note)? addNote;
  NoteWindow({Key? key, required this.justFollow, required this.addNote})
      : super(key: key);

  final _msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 6 * 25.0,
            margin: const EdgeInsets.all(10),
            child: TextField(
              maxLines: 6,
              controller: _msgController,
              decoration: InputDecoration(
                  hintText: "Add a note",
                  fillColor: DColors.bgGrey,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: 10.h),
          Row(children: [
            SizedBox(
              height: 35.h,
              width: MediaQuery.of(context).size.width / 3.2,
              child: TextButton(
                  onPressed: () {
                    addNote!(_msgController.text);
                    PageRouter.goBack(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.sizeXXL!),
                              side: const BorderSide(
                                  color: DColors.primaryColor)))),
                  child: TextWidget(
                    text: "Add Note",
                    appcolor: DColors.primaryColor,
                    size: FontSize.s13,
                    weight: FontWeight.w700,
                  )),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 35.h,
              width: MediaQuery.of(context).size.width / 3.2,
              child: TextButton(
                  onPressed: () {
                    justFollow!();
                    PageRouter.goBack(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          DColors.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(SizeConfig.sizeXXL!),
                              side: const BorderSide(
                                  color: DColors.primaryColor)))),
                  child: TextWidget(
                    text: "Just Follow",
                    appcolor: DColors.white,
                    size: FontSize.s13,
                    weight: FontWeight.w700,
                  )),
            )
          ]),
        ],
      ),
    );
  }
}
