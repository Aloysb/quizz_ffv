import 'package:flutter/material.dart';
import 'package:quizz_ffvl/views/component/QuestionsCard.dart';

class ChooseQuestionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          QuestionsCard(
            imagePath: 'assets/images/10.jpeg',
            numberOfQuestions: 10,
          ),
          QuestionsCard(
            imagePath: 'assets/images/30.jpeg',
            numberOfQuestions: 30,
          ),
          QuestionsCard(
            imagePath: 'assets/images/60.jpeg',
            numberOfQuestions: 60,
          ),
          QuestionsCard(
            imagePath: 'assets/images/90.jpeg',
            numberOfQuestions: 90,
          ),
        ],
      ),
    );
  }
}
