import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/model/card_information_model.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';
import 'package:quizz_ffvl/views/component/SelectCard.dart';

class ChooseCategoryView extends StatelessWidget {
  ChooseCategoryView({@required this.data})
      : cards = data
            .map((card) => CardInformation(
                  value: card['value'],
                  title: card['title'],
                  image: card['image'],
                  nextView: ChooseQuestionsView(),
                  onClickAction: () => Controller.setCategory(card['value']),
                ))
            .toList();

  final data;
  final List<dynamic> cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text('Catégorie ?'),
      ),
      body: ListView(
          children: cards
              .map((card) => SelectCard(
                    title: card.title,
                    imagePath: card.image,
                    nextView: card.nextView,
                    onClickAction: card.onClickAction,
                  ))
              .toList()),
    );
  }
}
