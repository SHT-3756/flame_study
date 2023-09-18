import 'package:fit_fighter/games/fit_fighter.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final FitFighterGame fitFighterGame = FitFighterGame();
  runApp(GameWidget(game: fitFighterGame));
}

