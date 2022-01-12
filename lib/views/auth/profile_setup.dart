import 'dart:io';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/back_arrow.dart';
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

class ProfileSetUp extends StatefulWidget {
  @override
  _ProfileSetUpState createState() => _ProfileSetUpState();
}

class _ProfileSetUpState extends State<ProfileSetUp> {
  late File _image;
  final _debouncer = Debouncer(milliseconds: 900);
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  bool checker = false;
  String output = "";
  bool result = true;
  AppState appState;
  AuthBloc _loginBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    print(appState.dob);
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocProvider<AuthBloc>(
              create: (context) => _loginBloc,
              child: BlocListener<AuthBloc, AuthState>(listener:
                  (context, state) async {
                if (state is Error) {
                  print(state.message);
                }
                if (state is VerifyUsernameLoaded) {
                  print(state.verifyUsernameEntity.codeNameExists);
                  output = !state.verifyUsernameEntity.codeNameExists
                      ? "Congrats! Username is available."
                      : state.verifyUsernameEntity.codeNameExists
                      ? "Oops! Taken already"
                      : "";
                  result = state.verifyUsernameEntity.codeNameExists;
                }
                if (state is CompleteRegistrationLoaded) {
                  appState.user =
                      json.decode(await sharedStore.getFromStore("user"));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => ConnectFriends()));
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
                            showModalBottomSheet(
                                backgroundColor: DColors.inputText,
                                // useRootNavigator:true,
                                context: context,
                                builder: (t) {
                                  return StatefulBuilder(builder:
                                      (BuildContext contxt,
                                      StateSetter setModalState) {
                                    return Container(
                                      // padding: const EdgeInsets.all(8.0),
                                      height: 190,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                // backgroundColor: MaterialStateProperty.all<Color>(DColors.inputColor),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        // side: BorderSide(color: Colors.red)
                                                      ))),
                                              onPressed: () {
                                                getImageFile(ImageSource.camera,
                                                    setModalState);
                                                Navigator.pop(context, true);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(2.0),
                                                child: TextWidget(
                                                  text: "Take Photo",
                                                  appcolor: Colors.blue,
                                                  type: "Objectivity",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                // backgroundColor: MaterialStateProperty.all<Color>(DColors.inputColor),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(0),
                                                        // side: BorderSide(color: Colors.red)
                                                      ))),
                                              onPressed: () {
                                                getImageFile(
                                                    ImageSource.gallery,
                                                    setModalState);
                                                Navigator.pop(context, true);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(2.0),
                                                child: TextWidget(
                                                  text: "Choose Photo",
                                                  appcolor: Colors.blue,
                                                  type: "Objectivity",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(DColors.white),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                        // side: BorderSide(color: Colors.red)
                                                      ))),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: TextWidget(
                                                  text: "Cancel",
                                                  appcolor: Colors.blue,
                                                  type: "Objectivity",
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: SizeConfig.sizeXXL!),
                              child: Stack(
                                children: [
                                  _image == null
                                      ? Image.asset(
                                    "assets/profile.png",
                                    height: 90,
                                    width: 90,
                                  )
                                      : CircleAvatar(
                                    backgroundImage: FileImage(
                                      _image,
                                    ),
                                    radius: 43,
                                  ),
                                  Positioned(
                                      left: 60.w,
                                      top: 60.h,
                                      child: CircleAvatar(
                                        backgroundColor:
                                        DColors.primaryAccentColor,
                                        radius: 15.r,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: DColors.white,
                                          size: 15.w,
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
                              _debouncer.run(() => context
                                  .read<AuthBloc>()
                                  .add(VerifyUsername(username: val)));
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
                                context.read<AuthBloc>().add(
                                    CompleteRegistration(
                                        username:
                                        _usernameController.text,
                                        phone: appState.phone,
                                        age: appState.dob,
                                        name: _nameController.text));
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
                                text: state is RegLoading
                                    ? "Loading"
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

  getImageFile(ImageSource source, setModalState) async {
    //Clicking or Picking from Gallery
    print("ttttt");

    var image = await ImagePicker().getImage(source: source);

    //Cropping the image

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        maxWidth: 512,
        maxHeight: 512,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

    //Compress the image
    final lastIndex = croppedFile.path.lastIndexOf(new RegExp(r'.jp'));
    final splitted = croppedFile.path.substring(0, (lastIndex));
    final targetPath =
        "${splitted}_out${croppedFile.path.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      targetPath,
      quality: 50,
    );
    print(result);

    setState(() {
      _image = result!;
      print(_image.lengthSync());
    });

    var token = await sharedStore.getFromStore("token".toString());

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://35.175.175.194/upload"));

    //Header....
    request.headers['Authorization'] = 'Bearer ' + json.decode(token);

    request.fields['type'] = "profile_picture";
    request.files.add(await http.MultipartFile.fromPath('image', result.path));
    var response = await request.send();
    print(response.stream);
    print(response.statusCode);
    final res = await http.Response.fromStream(response);
    print(res.body);
  }
}
