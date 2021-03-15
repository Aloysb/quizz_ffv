import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';
import 'dart:math';

class Controller extends ControllerMVC {
  // Controller constructor
  Controller() {
    print('Initialize Controller');
    //Initialize the model
    Model();
  }

  ///////////////////////////////////
  //QUIZ THEME AND LEVEL SELECTION///
  ///////////////////////////////////

  static List<String> _themesAvailable = [
    'général',
    'météo',
    'règlementation',
    'mécavol',
    'matériel'
  ];
  static List<String> get themesAvailable => _themesAvailable;
  static List<String> _levelsAvailable = ['BI', 'BP', 'BPC', 'ALL'];
  static List<String> get levelsAvailable => _levelsAvailable;
  static String _category;
  static String _level;

  static void setCategory(String category) {
    _category = category;
  }

  static void setLevel(String level) {
    _level = level;
  }

  static List<Map<String, dynamic>> _questions;

//Current index
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;

  //Selected answers
  static List<int> _selectedAnswers = [];
  static List<int> get selectedAnswers => _selectedAnswers;
  static bool _currentAnswersValidated = false;

  static int _currentScore = 0;
  static int get currentScore => _currentScore;
  static int _maxScore = 1;
  static int get maxScore => _maxScore;
  static int _numberOfQuestions;
  static int get numberOfQuestions => _numberOfQuestions;
  static int currentScoreInPercentage() {
    return ((_currentScore.toDouble() / _maxScore.toDouble()) * 100).round();
  }

  static void setNumberOfQuestions(int numberOfQuestions) {
    _numberOfQuestions = numberOfQuestions;
  }

  static void startQuiz() {
    String theme = _category;
    String level = _level;
    int length = _numberOfQuestions;

    if (!themesAvailable.contains(theme) | !levelsAvailable.contains(level)) {
      print('Error, wrong theme or level');
      return;
    }

    _index = 0;
    _currentScore = 0;

    _questions = Model.initializeQuiz(theme, level, length);

    //Add necessary fields to the question
    _questions.map((question) {
      question['validated'] = false;
      question['selectAnswers'] = [];
    });
  }

  static void validateAnswers() {
    _currentAnswersValidated = true;
    _currentAnswersPoint = Model.getPoints(_index);
    _currentScore += _selectedAnswers.length > 0
        ? max(
            _selectedAnswers
                .map((answer) => int.parse(_currentAnswersPoint[answer]))
                .reduce((a, b) => a + b),
            0)
        : 0;
    _maxScore = 6 * _index;
  }

  static void resetAnswersPoint() =>
      _currentAnswersPoint = [null, null, null, null];

  static void selectAnswer(int index) {
    _selectedAnswers.contains(index)
        ? _selectedAnswers.remove(index)
        : _selectedAnswers.add(index);
  }

  static bool isSelected(int index) {
    return _selectedAnswers.contains(index);
  }
}
