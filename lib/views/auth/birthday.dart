import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/profile_setup.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dice_app/views/widgets/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/date_picker.dart';


class Birthday extends StatefulWidget {
  @override
  _BirthdayState createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  late DateTime _selectedDate;
  TextEditingController _dobDate = TextEditingController();
  bool checker = false;
  final GlobalKey<FormState> dobKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 56.5.h),
                BackArrow(),
                SizedBox(height: 46.7.h),
                Container(
                  alignment: Alignment.center,
                  child: TextWidget(
                    text: "Almost there, kindly \nadd your birthday",
                    align: TextAlign.center,
                    appcolor: DColors.grey,
                    type: "Objectivity",
                    size: FontSize.s19,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 203.9.h),
                Form(
                  key: dobKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL!),
                    child: GestureDetector(
                      onTap: () {
                        pickDate(
                            context: context,
                            dateOptions: DateOptions.past,
                            onChange: (String pickedDate) {
                              setState(() {
                                _dobDate.text = pickedDate;
                                checker = true;
                              });
                            });
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dobDate,
                          validator: validateDate,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: DColors.inputText)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: DColors.inputText)),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "YYYY/MM/DD",
                            hintStyle: TextStyle(
                                color: const Color(0xFFE3E3E3),
                                fontSize: FontSize.s16),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.sizeXL!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXXL),
                //   child: Divider(
                //     color: DColors.inputText,
                //     thickness: 1.0,
                //   ),
                // ),
                SizedBox(height: SizeConfig.sizeMedium),
                Container(
                  alignment: Alignment.center,
                  child: TextWidget(
                    text: "This helps prevent children from joining Dice",
                    type: "Objectivity",
                    appcolor: DColors.faded,
                    size: FontSize.s12,
                  ),
                ),
                SizedBox(height: 83.3.h),
                Container(
                  width: double.infinity,
                  height: 44,
                  margin: EdgeInsets.symmetric(horizontal: 73.2.w),
                  child: TextButton(
                      onPressed: () {
                        if (dobKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileSetUp()));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: checker
                              ? MaterialStateProperty.all<Color>(
                                  DColors.primaryColor)
                              : MaterialStateProperty.all<Color>(
                                  const Color(0xFFF2F0F0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.sizeXXL!),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      child: TextWidget(
                        text: "NEXT",
                        weight: FontWeight.w700,
                        appcolor: checker ? Colors.white : DColors.faded,
                        size: FontSize.s12,
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
