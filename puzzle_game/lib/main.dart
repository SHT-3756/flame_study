import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_game/board.dart';
import 'package:puzzle_game/rank_llist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => Board()),
        GetPage(name: '/rank_list', page: () => RankList()),
      ],
      home: Board(),
    );
  }
}
