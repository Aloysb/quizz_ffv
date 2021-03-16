import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';

import 'package:quizz_ffvl/model/question_class.dart';

import 'package:quizz_ffvl/views/component/Headers.dart';
import 'package:quizz_ffvl/views/component/QuizAppBar.dart';

class QuizzView extends StatefulWidget {
  @override
  _QuizzViewState createState() => _QuizzViewState();
}

class _QuizzViewState extends StateMVC {
  PageController _pageController = PageController(initialPage: 0);

  _QuizzViewState() : super(Controller());

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: QuizAppBar(),
      body: Container(
        color: Colors.lightBlue[900],
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Headers(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: Controller.questions
                      .map(
                        (question) => QuestionCard(question: question),
                      )
                      .toList(),
                ),
              ),
              BottomButton()
            ],
          ),
        ),
      ),
    );
  }

  FlatButton BottomButton() {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Center(
        child: Text(
          'Valider',
          // Controller.currentAnswersPoint[0] == null ? 'Valider' : 'Suivant',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          Controller.validateQuestion(1);
          // Controller.isQuestionValidated(1)
          // ? Controller.getNextQuestion()
          // : Controller.validateAnswers();
        });
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key key, Question this.question}) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
              color: Colors.black.withOpacity(.2),
            ),
          ],
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              decoration: BoxDecoration(),
              child: Center(
                child: Text(
                  question.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.blue.withOpacity(.5),
              indent: 80.0,
              endIndent: 80.0,
            ),
            Expanded(
              child: Container(
                child: AnswersList(question: question),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswersList extends StatelessWidget {
  const AnswersList({Key key, @required this.question}) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          children: this.question.answers.asMap().entries.map(
        (entry) {
          int idx = entry.key;
          String answer = entry.value;

          return Answer(question: question, idx: idx);
        },
      ).toList()),
    );
  }
}

class Answer extends StatefulWidget {
  const Answer({
    Key key,
    @required this.question,
    @required this.idx,
  }) : super(key: key);

  final Question question;
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
          elevation:
              widget.question.selectedAnswers.contains(widget.idx) ? 1 : 0,
          shape: StadiumBorder(
            side: BorderSide(
                width: 2,
                color: widget.question.selectedAnswers.contains(widget.idx)
                    ? widget.question.points[widget.idx] != null
                        ? widget.question.points[widget.idx] > 0
                            ? Colors.green
                            : Colors.red
                        : Colors.blueAccent
                    : Colors.transparent),
          ),
          color: Colors.white.withOpacity(
              widget.question.selectedAnswers.contains(widget.idx) ? 1 : .4),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              widget.question.points[widget.idx] != null
                  ? widget.question.points[widget.idx] > 0
                      ? Icon(Icons.check, size: 20.0, color: Colors.green)
                      : Icon(Icons.clear, size: 20.0, color: Colors.red)
                  : Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: widget.question.selectedAnswers
                              .contains(widget.idx)
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: widget.question.selectedAnswers
                                              .contains(widget.idx) &&
                                          widget.question.points[widget.idx] !=
                                              null
                                      ? Colors.transparent
                                      : Colors.blueAccent,
                                  boxShadow: [],
                                ),
                              ),
                            )
                          : Container(),
                    ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  widget.question.question,
                  style: TextStyle(
                    color: widget.question.selectedAnswers.contains(widget.idx)
                        ? Colors.blue[900]
                        : Colors.blueGrey[600],
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                widget.question.points[widget.idx] ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                  color: widget.question.points[widget.idx] > 0
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              widget.question.toggleAnswer(widget.idx);
            });
          }),
    );
  }
}
