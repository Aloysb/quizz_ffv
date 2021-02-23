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
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Text(
                Controller.currentQuestion,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: AnswersList(answers: Controller.currentAnswers),
          ),
        ),
        RaisedButton(
          child: Text(Controller.index < 1 ? 'Start' : 'Next question'),
          onPressed: () {
            setState(() {
              Controller.index < 1
                  ? Controller.startQuiz('météo', 'brevet initial', 10)
                  : Controller.currentAnswersValidated
                      ? Controller.getNextQuestion()
                      : Controller.validateAnswers();
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            side: BorderSide(
                color: Controller.isSelected(widget.idx)
                    ? Colors.purpleAccent[700]
                    : Colors.grey[400],
                width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Controller.isSelected(widget.idx)
                      ? Colors.green
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Controller.isSelected(widget.idx)
                          ? Colors.purpleAccent
                          : Colors.black,
                      width: 1),
                ),
                child: Controller.isSelected(widget.idx)
                    ? Container(
                        child:
                            Icon(Icons.check, size: 16.0, color: Colors.white),
                      )
                    : Container(),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Controller.isSelected(widget.idx)
                        ? Colors.green
                        : Colors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                Controller.currentAnswersPoint[widget.idx] ?? '',
                style: TextStyle(
                  color: int.parse(Controller.currentAnswersPoint[widget.idx] ??
                              '0') >
                          0
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              Controller.selectAnswer(widget.idx);
            });
          }),
    );
  }
}
