import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';

class Headers extends StatelessWidget {
  const Headers({
    Key key,
    int this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.0,
        bottom: 18.0,
        top: 18.0,
        right: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlue[900],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Questions ${index}',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                '/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              Text(
                Controller.numberOfQuestions.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(Controller.currentScore.toString()),
              Text('/'),
              Text(Controller.maxScore.toString()),
              Controller.getScoreInPercent() < 75
                  ? Icon(
                      Icons.clear,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
              Text(
                Controller.getScoreInPercent().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
