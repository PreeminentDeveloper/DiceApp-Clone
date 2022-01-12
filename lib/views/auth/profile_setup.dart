import 'dart:io';
import 'package:dice_app/core/data/session_manager.dart';
import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/debouncer.dart';
import 'package:dice_app/core/util/helper.dart';
import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/auth/data/model/profile/profile_setup_model.dart';
import 'package:dice_app/views/auth/data/model/username/username_model.dart';
import 'package:dice_app/views/profile/provider/profile_service.dart';
import 'package:dice_app/views/profile/widget/image_modal.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
import 'package:dice_app/views/widgets/circle_image.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:dice_app/views/widgets/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'bloc/auth_bloc.dart';
import 'connect_friends.dart';
import 'widget/date_picker.dart';

class ProfileSetUp extends StatefulWidget {
  final String age;
  ProfileSetUp({required this.age});

  @override
  _ProfileSetUpState createState() => _ProfileSetUpState();
}

class _ProfileSetUpState extends State<ProfileSetUp> {
  File? _image;
  final _debouncer = Debouncer(milliseconds: 900);
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  bool checker = false;
  String output = "";
  bool result = true;
  bool _loadingState = false;
  final _bloc = AuthBloc(inject());
  ProfileProvider? _profileProvider;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _profileProvider?.getUsersInformations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocProvider<AuthBloc>(
              create: (context) => _bloc,
              child: BlocListener<AuthBloc, AuthState>(listener:
                  (context, state) {
                if (state is AuthLoadingState) {
                  setState(() => _loadingState = true);
                }
                if (state is AuthSuccessState) {
                  setState(() => _loadingState = false);
                  _profileProvider?.getUsersInformations();
                  PageRouter.gotoWidget(ConnectFriends(), context,
                      clearStack: true);
                }
                if (state is AuthVerifyUsernameSuccess) {
                  output = !state.response.codeNameExists!
                      ? "Congrats! Username is available."
                      : state.response.codeNameExists!
                          ? "Oops! Taken already"
                          : "";
                  result = state.response.codeNameExists!;
                }

                if (state is AuthFailedState) {
                  logger.d(state.message);
                  setState(() => _loadingState = false);
                }
              }, child:
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 56.5.h),
                        BackArrow(),
                        SizedBox(height: 46.7.h),
                        Container(
                          alignment: Alignment.center,
                          child: TextWidget(
                            text:
                                "Add a profile picture, \nyour name and username",
                            align: TextAlign.center,
                            type: "objectivity",
                            weight: FontWeight.w700,
                            size: FontSize.s19,
                            appcolor: DColors.grey,
                          ),
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.width/2),
                        GestureDetector(
                          onTap: () {
                            showSheet(
                              context,
                              child: ImageModal(
                                showDeleteButton: false,
                                fileCallBack: (File? file) {
                                  setState(() => _image = file);
                                  PageRouter.goBack(context);
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .uploadFile(file);
                                },
                              ),
                            );
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: SizeConfig.sizeXXL!),
                              child: Stack(
                                children: [
                                  CircleImageHandler(
                                    'assets/profile.png',
                                    imageFile: _image,
                                    radius: 43,
                                  ),
                                  Positioned(
                                      left: 60.w,
                                      top: 60.h,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            DColors.primaryAccentColor,
                                        radius: 12.r,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: DColors.white,
                                          size: 10.w,
                                        ),
                                      ))
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.sizeXXL!),
                          child: TextFormField(
                            controller: _nameController,
                            validator: validateInput,
                            onChanged: (String value) {
                              if (value.trim().isNotEmpty) {
                                setState(() {
                                  checker = true;
                                });
                              } else {
                                setState(() {
                                  checker = false;
                                });
                              }
                            },
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
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: const Color(0xFFE3E3E3),
                                  fontSize: FontSize.s12),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.sizeLarge!),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.sizeSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.sizeXXL!),
                          child: TextFormField(
                            onChanged: (String val) {
                              _validateUser(context, val);
                            },
                            controller: _usernameController,
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
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: const Color(0xFFE3E3E3),
                                  fontSize: FontSize.s12),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.sizeLarge!),
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 8),
                            child: TextWidget(
                              text: output,
                              size: FontSize.s11,
                              appcolor:
                                  result ? Colors.red : DColors.primaryColor,
                            )),
                        SizedBox(height: SizeConfig.sizeXXXL),
                        Container(
                          width: double.infinity,
                          height: 44,
                          margin: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 4,
                              vertical: 16.h),
                          child: TextButton(
                              onPressed: checker &&
                                      !result &&
                                      _usernameController.text.trim().isNotEmpty
                                  ? () {
                                      _bloc.add(ProfileSetUpEvent(
                                          profileSetupModel: ProfileSetupModel(
                                        phone: _profileProvider?.user?.phone,
                                        username: _usernameController.text,
                                        name: _nameController.text,
                                        age: widget.age,
                                        id: _profileProvider?.user?.id,
                                      )));
                                    }
                                  : () {},
                              style: ButtonStyle(
                                  backgroundColor: checker &&
                                          !result &&
                                          _usernameController.text
                                              .trim()
                                              .isNotEmpty
                                      ? MaterialStateProperty.all<Color>(
                                          DColors.primaryColor)
                                      : MaterialStateProperty.all<Color>(
                                          const Color(0xFFF2F0F0)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.sizeXXL!),
                                    // side: BorderSide(color: Colors.red)
                                  ))),
                              child: TextWidget(
                                text: _loadingState
                                    ? "Loading..."
                                    : "enter".toUpperCase(),
                                weight: FontWeight.w700,
                                appcolor: checker &&
                                        !result &&
                                        _usernameController.text
                                            .trim()
                                            .isNotEmpty
                                    ? DColors.white
                                    : DColors.faded,
                                size: FontSize.s12,
                              )),
                        )
                      ],
                    ),
                  ),
                );
              }))),
        ));
  }

  bool _isUsernameCompliant(String _username, [int minLength = 6]) {
    if (_username.isEmpty) {
      return false;
    }
    if (_username.contains(RegExp(r'[A-Z]'))) {
      output = 'Username can\t contain Upper case letters';
      result = true;
      setState(() {});
      return false;
    }
    if (_username.contains(RegExp(r'[!@#$%^&*(),?" " ":{}|<>]'))) {
      output = 'Username can\t contain special characters';
      result = true;
      setState(() {});
      return false;
    }
    output = '';
    result = false;
    setState(() {});
    return true;
  }

  void _validateUser(BuildContext context, String val) {
    if (_isUsernameCompliant(val)) {
      _debouncer.run(() =>
          _bloc.add(VerifyUsernameEvent(codeNameModel: CodeNameModel(val))));
    }
  }
}
