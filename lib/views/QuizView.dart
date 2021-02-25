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
    return Container(
      color: Colors.lightBlue[900],
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 12.0,
                bottom: 18.0,
                top: 18.0,
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue[900],
              ),
              child: Row(children: [
                Text(
                  'Questions ${Controller.index.toString()}',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  '/',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  Controller.numberOfQuestions.toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.blueGrey[50],
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(),
                          child: Center(
                            child: Text(
                              Controller.currentQuestion,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child:
                              AnswersList(answers: Controller.currentAnswers),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Center(
                child: Text(
                  Controller.currentAnswersPoint[0] == null
                      ? 'Valider'
                      : 'Suivant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
        ),
      ),
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
      child: RaisedButton(
          elevation: Controller.isSelected(widget.idx) ? 1 : 0,
          shape: StadiumBorder(
            side: BorderSide(
                width: 2,
                color: Controller.currentAnswersPoint[widget.idx] != null &&
                        Controller.isSelected(widget.idx)
                    ? int.parse(Controller.currentAnswersPoint[widget.idx]) > 0
                        ? Colors.green
                        : Colors.red
                    : Colors.transparent),
          ),
          color: Colors.white
              .withOpacity(Controller.isSelected(widget.idx) ? 1 : .4),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Controller.isSelected(widget.idx)
                          ? Colors.purpleAccent
                          : Colors.black,
                      width: 1),
                ),
                child: Controller.isSelected(widget.idx)
                    ? Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.red,
                        ),
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
                        ? Colors.blue[900]
                        : Colors.blueGrey[600],
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
