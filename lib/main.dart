import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mvc_pattern/mvc_pattern.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends AppMVC {
  App({Key key}) : super(key: key);

  List<String> answers = ['Answer A', 'Answer B', 'Answer C', 'Answer D'];

  Controller _con = Controller();

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
              RaisedButton(
                  child: Text('hello'),
                  onPressed: () {
                    // print(_con.data);
                  }),
              Expanded(
                child: Container(
                  child: AnswersList(answers: answers),
                ),
              ),
            ],
          )),
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
              text: answer,
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
          text,
          style: TextStyle(color: isSelected ? Colors.green : Colors.blue),
        ),
        onPressed: () {
          selectAnswer();
        });
  }
}

class Controller extends ControllerMVC {
  Model _mod;

  /// Singleton Factory
  factory Controller() {
    return Controller._();
  }

  /// Private constructor
  Controller._() {
    print('Initializing the controller');
    //Initialize the Model
    this._mod = Model();
  }

  List<dynamic> get data => _mod.data;

  void incrementCounter() {
    /// The Controller knows how to 'talk to' the Model. It knows the name, but Model does the work.
    Model._incrementCounter();
  }
}

class Model {
  List<List<dynamic>> _data;
  List<dynamic> get data => _data[0];

  factory Model() {
    return Model._();
  }

  Model._() {
    print('initializing the Model');

    loadAsset() async {
      final String dataFromCsv =
          await rootBundle.loadString("assets/data/data.csv");
      List<List<dynamic>> csvTable =
          CsvToListConverter(eol: '\n').convert(dataFromCsv);
      this._data = csvTable;
      print(_data);
    }

    loadAsset();
  }

  static int get counter => _counter;
  static int _counter = 0;
  static int _incrementCounter() => ++_counter;
}
