import 'package:dodo_game/click_to_start.dart';
import 'package:dodo_game/dodo.dart';
import 'package:dodo_game/score.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Stack(
                children: [
                  ClickToStart(gameHasStarted: gameHasStarted),
                  Score(scroe: score, bestScore: bestScore),
                  Dodo(dodoX: dodoX, dodoY: dodoY - dodoHeight, dodoWidth: dodoWidth, dodoHeight: dodoHeight)
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
    );
  }
}
