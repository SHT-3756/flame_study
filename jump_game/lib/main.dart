import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/game/doodle_dash.dart';

import 'game/widgets/game_over_overlay.dart';
import 'game/widgets/game_overlay.dart';
import 'game/widgets/main_menu_overlay.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Doodle',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final DoodleDash game = DoodleDash();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('doodle'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                // TODO : 이렇게 부모 위젯을 고정 시켜두면 다른 디바이스에서는 어떻게 나올까?
                maxHeight: 800,
                minHeight: 550,
              ),
              child: GameWidget(
                game: game,
                overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                  'gameOverlay': (context, game) => GameOverlay(game: (game as DoodleDash)),
                  'mainMenuOverlay': (context, game) => MainMenuOverlay(game as DoodleDash),
                  'gameOverOverlay': (context, game) => GameOverOverlay(game as DoodleDash),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
