import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:dice_app/views/widgets/textviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';


class People extends StatelessWidget{
  final String? text, subText, personId, photo;
  People(this.text, this.subText, this.personId, this.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.appPadding!),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            // radius: 15.0,
            backgroundImage: (photo != null ) ?
            NetworkImage(photo!) :
            const NetworkImage("https://via.placeholder.com/150"),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: text??"",
                size: FontSize.s16,
                weight: FontWeight.w500,
                appcolor: DColors.mildDark,
              ),
              SizedBox(height: 5),
              TextWidget(
                text: subText??"",
                size: FontSize.s10,
                weight: FontWeight.w500,
                appcolor: DColors.lightGrey,
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (_)=> OtherProfile(personId)));
              },
              child: SvgPicture.asset("assets/arrow-forward.svg")
          ),

        ],
      ),
    );
  }

}
