import 'package:dice_app/core/util/debouncer.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/profile/provider/profile_provider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dice_app/views/widgets/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ChangeUsername extends StatefulWidget {
  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final _usernameController = TextEditingController();
  final GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  bool checker = false;
  String output = "";
  bool result = true;
  ProfileProvider? _profileProvider;
  final _debouncer = Debouncer(milliseconds: 900);

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultAppBar(context, title: "Change Username"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeXL!),
              child: Form(
                key: usernameKey,
                child: Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: DColors.inputText,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0.0,
                    child: TextFormField(
                      controller: _usernameController,
                      validator: validatePhone,
                      onChanged: (input) {
                        _debouncer
                            .run(() => _profileProvider?.verifyUserName(input));
                        if (input.trim().isNotEmpty) {
                          checker = true;
                        } else {
                          checker = false;
                        }
                        setState(() {});
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "name",
                        hintStyle: TextStyle(
                            color: Color(0xFFE3E3E3),
                            fontSize: FontSize.s16,
                            fontFamily: "Objectivity"),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sizeXL!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8),
                        child: TextWidget(
                          text: provider.message ?? '',
                          size: FontSize.s11,
                          appcolor: result ? Colors.red : DColors.primaryColor,
                        )),

                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: SizeConfig.sizeXXXL!),
                      child: TextWidget(
                        text:
                            "Changing your username will make the \ncurrent one be up for grabs, proceed?",
                        appcolor: Color(0xFFB2B2B2),
                        size: FontSize.s14,
                        weight: FontWeight.w700,
                        height: 1.2,
                        type: "Objectivity",
                      ),
                    ),
                    // SizedBox(height: SizeConfig.sizeXXXL),
                    Container(
                      height: 44,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4),
                      child: TextButton(
                          onPressed: () {
                            if (!provider.message!.contains('Oops!')) {
                              _profileProvider?.updateUsersInfo(context,
                                  "username", _usernameController.text);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: checker && !result
                                  ? MaterialStateProperty.all<Color>(
                                      DColors.primaryColor)
                                  : MaterialStateProperty.all<Color>(
                                      Color(0xFFF2F0F0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.sizeXXL!),
                                // side: BorderSide(color: Colors.red)
                              ))),
                          child: TextWidget(
                            text: provider.profileEnum == ProfileEnum.busy
                                ? "LOADING..."
                                : "SAVE",
                            appcolor:
                                checker ? Colors.white : DColors.lightGrey,
                            size: FontSize.s14,
                            weight: FontWeight.w700,
                          )),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
