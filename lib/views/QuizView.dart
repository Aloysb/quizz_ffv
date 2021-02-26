import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/controller/main_controller.dart';
import 'package:quizz_ffvl/views/Home.dart';

class QuizzView extends StatefulWidget {
  @override
  _QuizzViewState createState() => _QuizzViewState();
}

class _QuizzViewState extends StateMVC {
  _QuizzViewState() : super(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Future<void> _showMyDialog() async {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Quitter le QCM'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'En quittant le QCM, votre progression sera perdue.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                              child: Text(
                                'Continuer',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {}),
                          TextButton(
                            child: Text(
                              'Quitter',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeView(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

                _showMyDialog();
              },
            );
          },
        ),
      ),
      body: Container(
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
                  right: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[900],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
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
                      ],
                    ),
                    Row(
                      children: [
                        // Controller.currentScoreInPercentage() < 75
                        //     ? Icon(
                        //         Icons.clear,
                        //         color: Colors.red,
                        //       )
                        //     : Icon(
                        //         Icons.check,
                        //         color: Colors.green,
                        //       ),
                        Text(
                          '${Controller.currentScoreInPercentage() == 0 && Controller.index == 0 ? "-" : Controller.currentScoreInPercentage().toString()} %',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
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
                          padding: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 30.0),
                          decoration: BoxDecoration(),
                          child: Center(
                            child: Text(
                              Controller.currentQuestion,
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
                    Controller.currentAnswersValidated
                        ? Controller.getNextQuestion()
                        : Controller.validateAnswers();
                  });
                },
              ),
            ],
          ),
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
      child: ListView(
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
                color: Controller.isSelected(widget.idx)
                    ? Controller.currentAnswersPoint[widget.idx] != null
                        ? int.parse(Controller
                                    .currentAnswersPoint[widget.idx]) >
                                0
                            ? Colors.green
                            : Colors.red
                        : Colors.blueAccent
                    : Colors.transparent),
          ),
          color: Colors.white
              .withOpacity(Controller.isSelected(widget.idx) ? 1 : .4),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Controller.currentAnswersPoint[widget.idx] != null
                  ? int.parse(Controller.currentAnswersPoint[widget.idx]) > 0
                      ? Icon(Icons.check, size: 20.0, color: Colors.green)
                      : Icon(Icons.clear, size: 20.0, color: Colors.red)
                  : Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Controller.isSelected(widget.idx)
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Controller.isSelected(widget.idx) &&
                                          Controller.currentAnswersPoint[
                                                  widget.idx] !=
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
                  widget.text,
                  style: TextStyle(
                    color: Controller.isSelected(widget.idx)
                        ? Colors.blue[900]
                        : Colors.blueGrey[600],
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                Controller.currentAnswersPoint[widget.idx] ?? '',
                style: TextStyle(
                  fontSize: 18.0,
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
