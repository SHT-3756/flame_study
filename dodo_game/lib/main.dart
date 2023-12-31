import 'dart:async';

import 'package:dodo_game/components/barricade.dart';
import 'package:dodo_game/components/click_to_start.dart';
import 'package:dodo_game/components/dodo.dart';
import 'package:dodo_game/components/game_has_over.dart';
import 'package:dodo_game/components/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool gameHasStarted = false;
  int score = 0;
  int bestScore = 0;

  double dodoX = -0.5;
  double dodoY = 1;
  double dodoWidth = 0.2;
  double dodoHeight = 0.4;

  double barricadeX = 0.5;
  double barricadeY = 1;
  double barricadeWidth = 0.2;
  double barricadeHeight = 0.4;

  bool gameHasOver = false;

  bool controlJump = false;
  double gravity = 9.8;
  double height = 0;
  double time = 0;
  double velocity = 5;

  bool dodoHasPassedBarricade = false;

  void startGame() {
    setState(() {
      gameHasStarted = true;
    });

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if(detectForCollision()) {
        gameHasOver = true;
        timer.cancel();
        setState(() {
          if(score > bestScore) {
            bestScore = score;
          }
        });
      }

      loopForBarricade();

      updateForScore();

      setState(() {
        barricadeX -= 0.01;
      });
    });
  }

  void updateForScore() {
    if (barricadeX < dodoX && dodoHasPassedBarricade == false) {
      setState(() {
        dodoHasPassedBarricade = true;
        score++;
      });
    }
  }

  void loopForBarricade() {
    setState(() {
      if (barricadeX <= -1.2) {
        barricadeX = 1.2;
        dodoHasPassedBarricade = false;
      }
    });
  }

  bool detectForCollision() {
    if (barricadeX <= dodoX + dodoWidth && barricadeX + barricadeWidth >= dodoX && dodoY >= barricadeY - barricadeHeight) {
      return true;
    } else {
      return false;
    }
  }

  void jumpDodo() {
    controlJump = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = -gravity / 2 * time * time + velocity * time;

      setState(() {
        if (1 - height > 1) {
          resetJump();
          dodoY = 1;
          timer.cancel();
        } else {
          dodoY = 1 - height;
        }
      });
      if (gameHasOver) {
        timer.cancel();
      }

      time += 0.01;
    });
  }

  void resetJump() {
    controlJump = false;
    time = 0;
  }

  void playGameAgain() {
    setState(() {
      gameHasOver = false;
      gameHasStarted = false;
      barricadeX = 1.2;
      score = 0;
      dodoY = 1;
      controlJump = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasOver ? (playGameAgain)
          : (gameHasStarted ? (controlJump ? null : jumpDodo): startGame),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Stack(
                  children: [
                    ClickToStart(gameHasStarted: gameHasStarted),
                    Score(score: score, bestScore: bestScore),
                    Dodo(dodoX: dodoX, dodoY: dodoY - dodoHeight, dodoWidth: dodoWidth, dodoHeight: dodoHeight),
                    Barricade(barricadeX: barricadeX, barricadeY: barricadeY - barricadeHeight, barricadeWidth: barricadeWidth, barricadeHeight: barricadeHeight),
                    GameHasOver(gameHasOver: gameHasOver)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[600],
              child: const Center(
                child: Text(
                  'W E C O D E',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
