import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseCategoryView.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key key,
    @required this.imagePath,
    @required this.title,
    @required this.onClickAction,
    @required this.nextView,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final Function onClickAction;
  final dynamic nextView;

  Function next(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextView),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: InkWell(
        onTap: () {
          onClickAction();
          print(nextView);
          next(context);
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Image.asset(
                this.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              // color: Colors.black.withOpacity(.2),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.5),
                  ],
                  radius: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                this.title,
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
    );
  }
}
