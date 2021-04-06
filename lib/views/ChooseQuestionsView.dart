import 'package:flutter/material.dart';
import 'package:quizz_ffvl/component/OptionSelection.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/ChooseLevelView.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';

class ChooseQuestionsView extends StatelessWidget {
  final List<dynamic> cards;

  ChooseQuestionsView({
    @required this.cards,
  });

  final nextView = ChooseLevelView(cards: Controller.getOptions('level'));

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
