import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseLevelView.dart';
import 'package:quizz_ffvl/views/QuizView.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({Key key, this.imagePath, this.level}) : super(key: key);

  final String imagePath;
  final String level;

  Function openQuiz(context) {
    Controller.startQuiz();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizzView(),
      ),
    );
  }

  String getFullTitle(level) {
    if (level == 'BI') return 'Initial';
    if (level == 'BP') return 'Pilote';
    if (level == 'BPC') return 'Pilote Confirmé';
    if (level == 'ALL') return 'Tous niveaux';
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
            Controller.setLevel(this.level);
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
                color: Colors.black.withOpacity(.3),
                alignment: Alignment.center,
                height: 180.0,
                child: Text(
                  getFullTitle(this.level),
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
