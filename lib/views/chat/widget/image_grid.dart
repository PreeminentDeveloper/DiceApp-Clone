import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: 15,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index) {
            return ImageLoader(
                imageLink: 'https://static.dw.com/image/58312486_403.jpg',
                fit: BoxFit.cover);
          }),
    );
  }
}
