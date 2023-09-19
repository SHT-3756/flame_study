import 'package:flutter/material.dart';

class ClickToStart extends StatelessWidget {
  final bool gameHasStarted;

  const ClickToStart({Key? key, required this.gameHasStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container()
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, 0),
                child: Image.asset('assets/images/start_game.png'),
              ),
              Container(
                alignment: const Alignment(0, -0.7),
                child: const Text(
                  'Dodo game',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
  }
}
