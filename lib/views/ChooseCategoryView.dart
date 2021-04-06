import 'package:flutter/material.dart';
import 'package:quizz_ffvl/component/OptionSelection.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';

class ChooseCategoryView extends StatelessWidget {
  final List<dynamic> cards;

  ChooseCategoryView({
    @required this.cards,
  });

  final nextView =
      ChooseQuestionsView(cards: Controller.getOptions('question'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptionSelection(
        cards: cards,
        nextView: nextView,
      ),
    );
  }
}
