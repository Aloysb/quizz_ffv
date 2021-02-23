import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';

class QuizzView extends StatefulWidget {
  @override
  _QuizzViewState createState() => _QuizzViewState();
}

class _QuizzViewState extends StateMVC {
  _QuizzViewState() : super(Controller());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(Controller.currentQuestion),
        ),
        Expanded(
          child: Container(
            child: AnswersList(answers: Controller.currentAnswers),
          ),
        ),
        RaisedButton(
          child: Text(Controller.index < 1 ? 'Start' : 'Next question'),
          onPressed: () {
            setState(() {
              Controller.getNextQuestion();
            });
          },
        ),
      ],
    );
  }
}

class AnswersList extends StatelessWidget {
  const AnswersList({Key key, @required this.answers}) : super(key: key);

  final List<String> answers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: this.answers.asMap().entries.map(
            (entry) {
              int idx = entry.key;
              String answer = entry.value;

              return Answer(text: answer, idx: idx);
            },
          ).toList()),
    );
  }
}

class Answer extends StatefulWidget {
  const Answer({
    Key key,
    @required this.text,
    @required this.idx,
  }) : super(key: key);

  final String text;
  final int idx;

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text(
          widget.text,
          style: TextStyle(
              color: Controller.isSelected(widget.idx)
                  ? Colors.green
                  : Colors.blue),
        ),
        onPressed: () {
          setState(() {
            Controller.selectAnswer(widget.idx);
          });
        });
  }
}
