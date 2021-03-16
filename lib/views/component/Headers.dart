import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';

class Headers extends StatelessWidget {
  const Headers({
    Key key,
  }) : super(key: key);

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
                'Questions ${Controller.index.toString()}',
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
              // Controller.currentScoreInPercentage() < 75
              //     ? Icon(
              //         Icons.clear,
              //         color: Colors.red,
              //       )
              //     : Icon(
              //         Icons.check,
              //         color: Colors.green,
              //       ),
              Text(
                '${Controller.currentScoreInPercentage() == 0 && Controller.index == 0 ? "-" : Controller.currentScoreInPercentage().toString()} %',
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
