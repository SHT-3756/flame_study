import 'package:flutter/material.dart';

import '../doodle_dash.dart';

class ScoreDisplay extends StatelessWidget {
  final DoodleDash game;
  final bool isLight;

  const ScoreDisplay({
    Key? key,
    required this.game,
    this.isLight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: game.gameManager.score,
        builder: (context, value, child) {
          return Text('Score: $value');
        });
  }
}
