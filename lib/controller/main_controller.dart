import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:quizz_ffvl/model/main_model.dart';

class Controller extends ControllerMVC {
  static int _index = 0;
  static get index => _index;
  static int incrementIndex() => _index++;
  static String _currentQuestion = '';
  static String get currentQuestion => _currentQuestion;
  static List<String> _currentAnswers = ['', '', '', ''];
  static List<String> get currentAnswers =>
      _currentAnswers.where((answer) => answer != '').toList();
  static List<bool> _selectedAnswers = [false, false, false, false];
  static List<bool> get selectedAnswers => _selectedAnswers;

  Controller() {
    Model();
  }

  static void startQuiz() {
    _index = 0;
    getNextQuestion();
  }

  static void getNextQuestion() {
    incrementIndex();
    _currentQuestion = Model.getQuestion(_index);
    _currentAnswers = Model.getAnswers(_index);
    _selectedAnswers = [false, false, false, false];
  }

  static void selectAnswer(int index) {
    _selectedAnswers[index] = !isSelected(index);
  }

  static bool isSelected(int index) {
    return selectedAnswers[index];
  }
}
