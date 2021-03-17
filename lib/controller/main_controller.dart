import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';
import 'dart:math';

import 'package:quizz_ffvl/model/question_class.dart';

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
  static List<String> _levelsAvailable = ['BI', 'BP', 'BPC', 'ALL'];
  static String _category;
  static String _level;

  static void setCategory(String category) {
    _category = category;
  }

  static void setLevel(String level) {
    _level = level;
  }

  static List<Question> _questions;
  static List<Question> get questions => _questions;

//Current index
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;

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
    _questions = [];

    if (!_themesAvailable.contains(theme) | !_levelsAvailable.contains(level)) {
      print('Error, wrong theme or level');
      return;
    }

    _index = 0;
    _currentScore = 0;
    _questions = Model.initializeQuiz(theme, level, length);
  }

  static void selectAnswer(int questionIndex, int index) {
    _questions[questionIndex].toggleAnswer(index);
  }

  static bool isSelected(int questionIndex, int index) {
    return _questions[questionIndex].selectedAnswers.contains(index);
  }

  static void validateQuestion(int questionIndex) {
    List<int> currentAnswersPoint = _questions[questionIndex].points;
    List<int> selectedAnswers = _questions[questionIndex].selectedAnswers;
    _questions[questionIndex].validateAnswers();

    _currentScore += selectedAnswers.length > 0
        ? max(
            selectedAnswers
                .map((answer) => currentAnswersPoint[answer])
                .reduce((a, b) => a + b),
            0)
        : 0;
    _maxScore = 6 * _index;
  }
}
