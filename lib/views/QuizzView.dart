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
        RaisedButton(
            child: Text('Start'),
            onPressed: () {
              Controller.incrementIndex();
              Controller.getNextQuestion();
              print(Controller.index);
              // Controller.getNextAnswers();
            }),
        // Expanded(
        //   child: Container(
        //     child: AnswersList(answers: Controller.currentAnswers),
        // ),
        // ),
      ],
    );
  }
}

class AnswersList extends StatefulWidget {
  AnswersList({@required this.answers});
  final List<String> answers;

  @override
  _AnswersListState createState() => _AnswersListState();
}

class _AnswersListState extends State<AnswersList> {
  List<bool> _selectedAnswer = [false, false, false, false];

  void selectAnswer(int index) {
    setState(() {
      _selectedAnswer[index] = _selectedAnswer[index] == true ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.answers.asMap().entries.map((entry) {
          int idx = entry.key;
          String answer = entry.value;

          return Answer(
              text: 'hello',
              isSelected: _selectedAnswer[idx],
              selectAnswer: () => selectAnswer(idx));
        }).toList(),
      ),
    );
  }
}

class Answer extends StatelessWidget {
  const Answer(
      {Key key,
      @required this.isSelected,
      @required this.text,
      @required this.selectAnswer})
      : super(key: key);

  final String text;
  final Function selectAnswer;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text(
          'here',
          style: TextStyle(color: isSelected ? Colors.green : Colors.blue),
        ),
        onPressed: () {
          selectAnswer();
        });
  }
}
