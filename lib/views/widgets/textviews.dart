import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//reusable text component
class TextWidget extends StatelessWidget {
  final String? text, type;
  final Function()? onTap;
  final TextOverflow? textOverflow;
  final FontWeight? weight;
  final double? size, space, height;
  final Color? appcolor;
  final TextAlign? align;
  final int? maxLines;

  TextWidget(
      {this.onTap,
      this.text,
      this.weight,
      this.size,
      this.appcolor,
      this.align,
      this.space,
      this.maxLines,
      this.type,
      this.textOverflow,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text ?? '',
        style: TextStyle(
            fontFamily: type,
            fontWeight: weight,
            fontSize: size,
            color: appcolor,
            letterSpacing: space,
            height: height),
        overflow: textOverflow,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}
