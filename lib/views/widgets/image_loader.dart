import 'package:cached_network_image/cached_network_image.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageLink;
  final BoxFit? fit;
  final Function()? onTap;

  const ImageLoader(
      {Key? key, this.onTap, this.fit, this.height, this.width, this.imageLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageLink!.contains('svg')) {
      return GestureDetector(onTap: onTap, child: SvgPicture.asset(imageLink!));
    }
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageLink!,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
                backgroundColor: DColors.primaryColor)),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fadeOutDuration: const Duration(seconds: 1),
        fadeInDuration: const Duration(seconds: 3),
      ),
    );
  }
}
