import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen(); // 풀 스크린
  Flame.device.setLandscape(); // 가로 화면

  PixelAdventure game = PixelAdventure();
  runApp(
    GameWidget(game: kDebugMode ? PixelAdventure() : game),
  );
}
