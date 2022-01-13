import 'package:dice_app/core/util/pallets.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String img;
  const DetailScreen(this.img);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130.0),
        child: AppBar(
          backgroundColor: DColors.white,
          elevation: 0.5,
          iconTheme: const IconThemeData(color: DColors.accentColor),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
              ),
            ),
          ),
        ),
      ),
      body: Hero(
        tag: 'profile-img-tag',
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Colors.red,
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(img)),
            ),
          ),
        ),
      ),
    );
  }
}
