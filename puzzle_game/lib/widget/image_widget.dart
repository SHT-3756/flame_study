import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  String imagePath;

  ImageWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill
        ),

      ),
    );
  }
}
