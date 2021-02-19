import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  List<String> answers = ['Answer A', 'Answer B', 'Answer C', 'Answer D'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFVL QCM Entrainement',
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Quizz'),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                child: Text('Question 1:'),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                        answers.map((answer) => Answer(text: answer)).toList(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class Answer extends StatelessWidget {
  const Answer({
    Key key,
    String this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
      onPressed: () => '',
    );
  }
}
