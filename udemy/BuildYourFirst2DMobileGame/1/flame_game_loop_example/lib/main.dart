import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(game: MyFirstGame())
  );
}

class MyFirstGame extends FlameGame {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
