import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/card_information_model.dart';
import 'package:quizz_ffvl/model/main_model.dart';
import 'dart:math';
import 'package:quizz_ffvl/model/question_class.dart';
import 'package:quizz_ffvl/views/QuizView.dart';

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

  static List<dynamic> _getCards(data, onClickAction) {
    return data
        .map((card) => CardInformation(
              value: card['value'],
              title: card['title'],
              image: card['image'],
              onClickAction: () => onClickAction(card['value']),
            ))
        .toList();
  }

  static getOptions(option) {
    List<dynamic> cards;
    Function action;

    switch (option) {
      case 'category':
        action = (String value) => setCategory(value);
        cards = _getCards(
          Model.optionData('category'),
          action,
        );
        return cards;
        break;
      case 'question':
        action = (String value) => setCategory(value);
        return _getCards(
          Model.optionData('question'),
          action,
        );
        break;
      case 'level':
        action = (String value) => setCategory(value);
        return _getCards(
          Model.optionData('level'),
          action,
        );
        break;
    }
  }

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
  static int _numberOfQuestions;

  static int get numberOfQuestions => _numberOfQuestions;

  static void setCategory(String category) {
    _category = category;
  }

  static void setLevel(String level) {
    _level = level;
  }

  static void setNumberOfQuestions(int length) {
    _numberOfQuestions = length;
  }

  static List<Question> _questions;
  static List<Question> get questions => _questions;

//Current index
  static int _index;
  static int _incrementIndex() => _index++;
  static int _currentScore;
  static int get currentScore => _currentScore;
  static int _maxScore = 1;
  static int get maxScore => _maxScore;

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
    _numberOfQuestions = _questions.length;
  }

  static void selectAnswer(int questionIndex, int index) {
    _questions[questionIndex].toggleAnswer(index);
  }

  static bool isSelected(int questionIndex, int index) {
    return _questions[questionIndex].selectedAnswers.contains(index);
  }

  static void validateQuestion(int questionIndex) {
    Question question = _questions[questionIndex];

    int score = question.validateAnswers();

    _incrementIndex();
    _currentScore += score;
    _maxScore = 6 * (_index + 1);
  }

  static int getScoreInPercent() {
    print(_maxScore);
    return (_currentScore * 100 ~/ _maxScore);
  }
}
