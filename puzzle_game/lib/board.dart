import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puzzle_game/widget/grid_widget.dart';
import 'package:puzzle_game/widget/image_widget.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,];
  int noOfMoves = 0;
  late Timer _timer;
  int _timerCount = 0;

  @override
  void initState() {
    super.initState();

    // number.shuffle();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_timerCount'),
            Center(
              child: Text(
                "${noOfMoves}Moves | 15 Tiles",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
              child: GridWidget(
                number: number,
                onClick: onClick,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5,
              ),
              onPressed: () {
                setState(() {
                  number.shuffle();
                });
              },
              child: const Text(
                'shuffle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5,
              ),
              onPressed: () => checkWinner(),
              child: const Text(
                'check',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClick(index) {
    // 비어있는 곳의 인덱스와 내가 누르는 인덱스를 비교하는 문
    if (index - 1 >= 0 && number[index - 1] == 0 && index % 4 != 0 || // 오른쪽
        index + 1 < 16 && number[index + 1] == 0 && (index + 1) % 4 != 0 || // 왼쪽
        (index - 4 >= 0 && number[index - 4] == 0) || // 아래
        (index + 4 < 16 && number[index + 4] == 0)) {
      // 위
      setState(() {
        number[number.indexOf(0)] = number[index];
        number[index] = 0;
        noOfMoves++;
      });
    }
    checkWinner();

    // 첫번쨰 일때만 감지
    if (noOfMoves == 1) {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _timerCount++;
        });
      });
    }
  }

  // 정렬되었는지 확인하는 함수
  bool isSortSuccess(List numberList) {
    int first = numberList.first;
    print(numberList.indexOf(0));
    // numberList.s
    for (int i = 1; i < numberList.length; i++) {
      int nextNumber = numberList[i];
      if (first > nextNumber) return false; // 첫번째 숫자가 다음 숫자 보다 크다면?
      first = numberList[i]; // 첫번쨎 숫자 다음 숫자로 재할당;
    }
    return true;
  }

  void checkWinner() {
    bool isWinner = isSortSuccess(number);
    if (isWinner) {
      print(_timerCount);
      _timer.cancel();
    } else {
      print("Not shorted");
    }
  }
}
