import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/widgets/custom_divider.dart';
import 'package:dice_app/views/widgets/default_appbar.dart';
import 'package:dice_app/views/widgets/grey_card.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conversation extends StatelessWidget {
  Conversation({Key? key}) : super(key: key);

  HomeProvider? _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: defaultAppBar(context, title: "Conversation"),
      ),
      body: Column(
        children: [
          GreyContainer(title: "Your Conversations"),
          const SizedBox(height: 20),

          ...List.generate(_homeProvider!.list!.length, (index) {
            final user = _homeProvider!.list!;

            return Column(children: [
              ...user
                  .map((user) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomeDivider(thickness: .3)
                          _item(user),
                          CustomeDivider()
                        ],
                      ))
                  .toList()
            ]);
          }).toList(),
          // _item("DanMan"),
          // CustomeDivider(),
          // _item("@dan"),
          // CustomeDivider()
        ],
      ),
    );
  }

  Widget _item(person) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.appPadding!),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 15.0,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: person.name,
                size: FontSize.s13,
                weight: FontWeight.w500,
                appcolor: DColors.mildDark,
              ),
              const SizedBox(height: 5),
              TextWidget(
                text: person.username,
                size: FontSize.s10,
                weight: FontWeight.w500,
                appcolor: DColors.lightGrey,
              ),
            ],
          ),
          const Spacer(),
          TextWidget(
            text: "131",
          ),
          const SizedBox(width: 15),
          const Icon(
            Icons.remove_red_eye_outlined,
            color: DColors.inputBorderColor,
            size: 15,
          )
        ],
      ),
    );
  }
}
