import 'package:dice_app/views/widgets/pop_menu/items.dart';
import 'package:dice_app/views/widgets/pop_menu/pop_up_menu.dart';
import 'package:dice_app/views/widgets/pop_menu_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatEditBox extends StatelessWidget {
  final Function(String)? onChanged;
  final bool? isEnabled;
  final TextEditingController? msgController;
  final Function()? addMessage;
  final Function(String value)? showGeneralDialog;
  final Function(PopMenuOptions option)? onMenuPressed;

  const ChatEditBox({
    Key? key,
    @required this.onChanged,
    @required this.isEnabled,
    @required this.msgController,
    @required this.addMessage,
    @required this.showGeneralDialog,
    @required this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Color(0xfff7f7f7)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xff6F7170), width: 0.5),
              color: Colors.white),
          // height: 40,
          child: Row(
            crossAxisAlignment:
                isEnabled! ? CrossAxisAlignment.end : CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  onChanged: onChanged,
                  controller: msgController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    // fillColor: DColors.white,
                    hintStyle: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    // filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              if (isEnabled!)
                GestureDetector(
                    onTap: addMessage,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: SvgPicture.asset(
                          "assets/send.svg",
                          height: 20,
                        ))),
              if (!isEnabled!)
                PopMenuWidget(
                  primaryWidget: Container(
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset("assets/add.svg")),
                  menuItems: PostsMenuModel.chatStickers(),
                  menuCallback: (option) {
                    onMenuPressed!(option);
                    controller.hideMenu();
                  },
                ),
              if (!isEnabled!)
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: SvgPicture.asset("assets/camera.svg")),
            ],
          )),
    );
  }
}
