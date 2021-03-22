import 'package:flutter/material.dart';
import 'package:quizz_ffvl/views/component/QuestionsCard.dart';

class ChooseQuestionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
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
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    spreadRadius: 1.0,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
