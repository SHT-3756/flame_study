import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 비동기로 기다리는 이유는 처음에는 세로로 실행되니깐, 조이스틱 위치 이슈 방지 위함.
  await Flame.device.fullScreen(); // 풀 스크린
  await Flame.device.setLandscape(); // 가로 화면

  PixelAdventure game = PixelAdventure();
  runApp(
    GameWidget(game: kDebugMode ? PixelAdventure() : game),
  );
}
