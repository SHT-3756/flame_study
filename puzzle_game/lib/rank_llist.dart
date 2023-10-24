import 'package:flutter/material.dart';

class RankList extends StatelessWidget {
  const RankList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Rank'),
          Card(child: Text('1'),)
        ],
      ),
    );
  }
}
