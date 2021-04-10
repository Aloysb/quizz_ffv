import 'package:flutter/material.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/model/card_information_model.dart';
import 'package:quizz_ffvl/views/ChooseQuestionsView.dart';
import 'package:quizz_ffvl/component/OptionCard.dart';

class OptionSelection extends StatelessWidget {
  final List<dynamic> cards;
  final nextView;

  OptionSelection({
    @required this.cards,
    @required this.nextView,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            // padding: EdgeInsets.only(top: 0),
            children: this
                .cards
                .map(
                  (card) => Expanded(
                    child: OptionCard(
                      imagePath: card.image,
                      nextView: nextView,
                      onClickAction: card.onClickAction,
                      title: card.title,
                    ),
                  ),
                )
                .toList(),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    spreadRadius: 1.0,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
