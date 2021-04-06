import 'package:flutter/material.dart';
import 'package:quizz_ffvl/component/OptionSelection.dart';
import 'package:quizz_ffvl/views/QuizView.dart';

class ChooseLevelView extends StatelessWidget {
  final List<dynamic> cards;

  ChooseLevelView({
    @required this.cards,
  });

  final nextView = QuizzView();

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
