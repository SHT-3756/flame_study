import 'package:flutter/material.dart';
import 'package:jump_game/game/doodle_dash.dart';

import 'scroe_display.dart';

class GameOverlay extends StatefulWidget {
  final DoodleDash game;

  const GameOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  // 게임 일시 중지 상태
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // 점수
          Positioned(
            child: ScoreDisplay(game: widget.game),
          ),
          Positioned(
            child: ElevatedButton(
              child: isPaused ? const Icon(Icons.play_arrow, size: 40) : const Icon(Icons.pause, size: 40),
              onPressed: () {
                widget.game.togglePauseState();
                setState(() {
                  isPaused = !isPaused;
                });
              },
            ),
          ),

          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            )
        ],
      ),
    );
  }
}
