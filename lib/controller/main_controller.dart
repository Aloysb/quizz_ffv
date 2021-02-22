import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';

class Controller extends ControllerMVC {
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;
  static String _currentQuestion;
  static String get currentQuestion => _currentQuestion;
  static List<String> _currentAnswers;
  static List<String> get currentAnswers => _currentAnswers;

  Controller() {
    Model();
  }

  static void getNextQuestion() {
    _currentQuestion = Model.getQuestion(_index);
    print(_currentQuestion);
  }

  static void getNextAnswers() {
    _currentAnswers = Model.getAnswers(_index);
  }
}
