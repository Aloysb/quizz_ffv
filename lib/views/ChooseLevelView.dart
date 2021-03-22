import 'package:flutter/material.dart';
import 'package:quizz_ffvl/views/component/LevelCard.dart';
import 'package:quizz_ffvl/views/component/QuestionsCard.dart';

class ChooseLevelView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('Niveau ?'),
      ),
      body: Column(
        children: [
          LevelCard(
            imagePath: 'assets/images/BI.jpg',
            level: 'BI',
          ),
          LevelCard(
            imagePath: 'assets/images/BP.jpeg',
            level: 'BP',
          ),
          LevelCard(
            imagePath: 'assets/images/BPC.jpeg',
            level: 'BPC',
          ),
          LevelCard(
            imagePath: 'assets/images/ALL.jpeg',
            level: 'ALL',
          ),
        ],
      ),
    );
  }
}
