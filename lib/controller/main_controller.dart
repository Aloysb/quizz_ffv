import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';
import 'dart:math';

class Controller extends ControllerMVC {
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;
  static String _currentQuestion = '';
  static String get currentQuestion => _currentQuestion;
  static List<String> _currentAnswers = ['', '', '', ''];
  static List<String> get currentAnswers =>
      _currentAnswers.where((answer) => answer != '').toList();
  static List<int> _selectedAnswers = [];
  static List<int> get selectedAnswers => _selectedAnswers;
  static List<String> _themesAvailable = [
    'général',
    'météo',
    'règlementation',
    'mécavol',
    'matériel'
  ];
  static List<String> get themesAvailable => _themesAvailable;
  static List<String> _levelsAvailable = [
    'brevet initial',
    'brevet de pilote',
    'brevet de pilote confirmé',
    'tous'
  ];
  static List<String> get levelsAvailable => _levelsAvailable;
  static bool _currentAnswersValidated = false;
  static bool get currentAnswersValidated => _currentAnswersValidated;
  static List<dynamic> _currentAnswersPoint = [null, null, null, null];
  static List<dynamic> get currentAnswersPoint => _currentAnswersPoint;
  static int _currentScore;
  static int get currentScore => _currentScore;
  static int _maxScore;
  static int get maxScore => _maxScore;
  static int _numberOfQuestions;
  static int get numberOfQuestions => _numberOfQuestions;

  Controller() {
    Model();
  }

  static void startQuiz(
    String theme,
    String level,
    int length,
  ) {
    if (!themesAvailable.contains(theme) | !levelsAvailable.contains(level)) {
      print('Error, wrong theme or level');
      return;
    }

    _index = 0;
    _currentScore = 0;
    _numberOfQuestions = length;
    Model.initializeQuiz(theme, level, length);
    getNextQuestion();
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
    print(_currentScore);
    print(_maxScore);
  }

  static void getNextQuestion() {
    incrementIndex();
    resetAnswersPoint();
    _currentQuestion = Model.getQuestion(_index);
    _currentAnswers = Model.getAnswers(_index);
    _selectedAnswers = [];
    _currentAnswersValidated = false;
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
