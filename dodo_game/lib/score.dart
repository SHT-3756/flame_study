import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final bestScore;
  final scroe;

  const Score({Key? key, this.bestScore, this.scroe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset('assets/images/score.png', width: 60),
              Text(
                scroe.toString(),
                style: const TextStyle(color: Colors.green, fontSize: 30),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                bestScore.toString(),
                style: const TextStyle(color: Colors.green, fontSize: 30),
              )
            ],
          )
        ],
      ),
    );
  }
}
