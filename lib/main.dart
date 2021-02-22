import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mvc_pattern/mvc_pattern.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  Controller _con = Controller();
  List<String> answers;

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
                child: Text(_con.currentQuestion),
              ),
              RaisedButton(
                  child: Text('Start'),
                  onPressed: () {
                    _con.getNextQuestion();
                    _con.getNextAnswers();
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
  /// Singleton Factory
  factory Controller() {
    return Controller._();
  }

  /// Private constructor
  Controller._() {
    print('Initializing the controller');
    //Initialize the Model
    this._mod = Model();
    this._index = -1;
    this._currentQuestion = '';
  }

  Model _mod;
  int _index;
  String _currentQuestion;
  String get currentQuestion => this._currentQuestion;
  List<String> _currentAnswers;
  List<String> get currentAnswers => this._currentAnswers;

  void incrementIndex() {
    _index++;
  }

  void getNextQuestion() {
    incrementIndex();
    this._currentQuestion = _mod.getQuestion(_index);
    print(this._currentQuestion);
  }

  void getNextAnswers() {
    this._currentAnswers = _mod.getAnswers(_index);
  }
}

class Model {
  //Singleton Factory
  factory Model() {
    return Model._();
  }

  //Private Constructor
  Model._() {
    print('initializing the Model');

    loadAsset() async {
      final String dataFromCsv =
          await rootBundle.loadString("assets/data/data.csv");
      List<List<dynamic>> csvTable =
          CsvToListConverter(fieldDelimiter: ',', eol: '\n')
              .convert(dataFromCsv);
      this._data = csvTable;
      this._questionIndex = 1;
      this._answersIndexes = [2, 4, 6, 8];
    }

    loadAsset();
  }

  List<List<dynamic>> _data;
  int _questionIndex;
  List<int> _answersIndexes;

  String getQuestion(int index) {
    return _data[index][1];
  }

  List<String> getAnswers(int index) {
    _answersIndexes.map((answerIndex) => _data[index][answerIndex]);
  }
}
