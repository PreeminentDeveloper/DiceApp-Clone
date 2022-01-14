import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class GifGrid extends StatelessWidget {
  const GifGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: 15,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index) {
            return const ImageLoader(
                imageLink:
                    'https://cdn.vox-cdn.com/thumbor/EaUuzIdnUGXAs_LokdLgtdrJZCY=/0x0:420x314/1400x1050/filters:focal(136x115:202x181):format(gif)/cdn.vox-cdn.com/uploads/chorus_image/image/55279403/tenor.0.gif',
                fit: BoxFit.cover);
          }),
    );
  }
}
