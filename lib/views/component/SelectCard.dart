import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';

class SelectCard extends StatelessWidget {
  const SelectCard({
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
      MaterialPageRoute(
        builder: (context) => nextView,
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
            print('here');
            onClickAction();
            next(context);
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
      ),
    );
  }
}
