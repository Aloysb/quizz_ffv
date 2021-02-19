import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
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
                    children: [
                      RaisedButton(
                        child: Text('Answer 1'),
                        onPressed: () => '',
                      ),
                      Text('Answer 2'),
                      Text('Answer 3'),
                      Text('Answer 4'),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
