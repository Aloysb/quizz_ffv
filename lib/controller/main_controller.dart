import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';
import 'dart:math';

import 'package:quizz_ffvl/model/question_class.dart';

class Controller extends ControllerMVC {
<<<<<<< Updated upstream
  // Controller constructor
  Controller() {
    print('Initialize Controller');
    //Initialize the model
    Model();
  }

  ///////////////////////////////////
  //QUIZ THEME AND LEVEL SELECTION///
  ///////////////////////////////////

=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

  static void setCategory(String category) {
    _category = category;
  }

  static void setLevel(String level) {
    _level = level;
  }

  static List<Question> _questions;
  static List<Question> get questions => _questions;

//Current index
=======
  static void setCategory(String category) => _category = category;
  static void setLevel(String level) => _level = level;

>>>>>>> Stashed changes
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;

<<<<<<< Updated upstream
=======
  static var _questions = [];
  static get questions => _questions;
  static String get currentQuestion => _questions[_index]['question'];
  static List<String> get currentAnswers =>
      _questions[_index]['answers'].where((answer) => answer != '').toList();

  static List<dynamic> _currentAnswersPoint = questions[_index]['points'];
  static List<dynamic> get currentAnswersPoint => _currentAnswersPoint;

  static List<int> _selectedAnswers = [];
  static bool isSelected(int index) => _selectedAnswers.contains(index);
  static void selectAnswer(int index) => _selectedAnswers.contains(index)
      ? _selectedAnswers.remove(index)
      : _selectedAnswers.add(index);

>>>>>>> Stashed changes
  static int _currentScore = 0;
  static int get currentScore => _currentScore;
  static int _maxScore = 1;
  static int get maxScore => _maxScore;
<<<<<<< Updated upstream
  static int _numberOfQuestions;
  static int get numberOfQuestions => _numberOfQuestions;
=======

  static int _numberOfQuestions;
  static int get numberOfQuestions => _numberOfQuestions;
  static void setNumberOfQuestions(int numberOfQuestions) =>
      _numberOfQuestions = numberOfQuestions;

>>>>>>> Stashed changes
  static int currentScoreInPercentage() {
    return ((_currentScore.toDouble() / _maxScore.toDouble()) * 100).round();
  }

<<<<<<< Updated upstream
  static void setNumberOfQuestions(int numberOfQuestions) {
    _numberOfQuestions = numberOfQuestions;
=======
  Controller() {
    print('Initialize Controller');
    Model();
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
    Model.initializeQuiz(theme, level, length);
    getNextQuestion();
  }

  static void validateAnswers() {
    Model.getPoints(_index);
    _currentScore += _selectedAnswers.length > 0
        ? max(
            _selectedAnswers
                .map((answer) => int.parse(_currentAnswersPoint[answer]))
                .reduce((a, b) => a + b),
            0)
        : 0;
    _maxScore = 6 * _index;
  }

  static void getNextQuestion() {
    incrementIndex();
    _questions.add([Model.getNextQuestion(_index), Model.getAnswers(_index)]);
    _selectedAnswers = [];
>>>>>>> Stashed changes
  }
}
