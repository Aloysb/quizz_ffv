import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.imagePath, this.category, this.title})
      : super(key: key);

  final String imagePath;
  final String category;
  final String title;

  Function openQuiz(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseQuestionsView(),
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
            Controller.setCategory(this.category);
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