import 'package:flutter/material.dart';

class GameHasOver extends StatelessWidget {
  bool gameHasOver;

  GameHasOver({
    Key? key,
    required this.gameHasOver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gameHasOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.7),
                child: Text(
                  'Ohhhhh no..... ',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: Image.asset('assets/images/game_over.png'),
              )
            ],
          )
        : Container();
  }
}
