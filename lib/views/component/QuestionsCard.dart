import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseLevelView.dart';

class QuestionsCard extends StatelessWidget {
  const QuestionsCard({Key key, this.imagePath, this.numberOfQuestions})
      : super(key: key);

  final String imagePath;
  final int numberOfQuestions;

  Function openQuiz(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseLevelView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Container(
        child: InkWell(
          onTap: () {
            Controller.setNumberOfQuestions(this.numberOfQuestions);
            openQuiz(context);
          },
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  this.imagePath,
                  height: 180.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black.withOpacity(.2),
                alignment: Alignment.center,
                height: 180.0,
                child: Text(
                  '${this.numberOfQuestions.toString()} questions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
