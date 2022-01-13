import 'package:dice_app/views/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class VideoGrid extends StatelessWidget {
  const VideoGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: 15,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index) {
            return const ImageLoader(
                imageLink:
                    'https://images.squarespace-cdn.com/content/v1/591dded4d1758eccdeed1fc6/1548462662454-7UR0S69MSGHQARC6FLNW/Bey.jpg',
                fit: BoxFit.cover);
          }),
    );
  }
}
