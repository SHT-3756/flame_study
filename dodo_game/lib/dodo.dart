import 'package:flutter/material.dart';

class Dodo extends StatelessWidget {
  final double dodoX;
  final double dodoY;
  final double dodoWidth;
  final double dodoHeight;

  const Dodo({Key? key, required this.dodoX, required this.dodoY, required this.dodoWidth, required this.dodoHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * dodoX + dodoWidth) / (2 - dodoWidth), (2 * dodoY + dodoHeight) / (2 - dodoHeight)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 2 / 3 * dodoHeight / 2,
        width: MediaQuery.of(context).size.width * dodoWidth / 2,
        child: Image.asset(
          'assets/images/dodo.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
