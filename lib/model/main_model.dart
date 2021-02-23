import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

/*
Un questionnaire est considéré comme réussi si le score est d'au moins 75%.

Suivant les recommandations de la FFVL, chaque série de 10 questions est répartie comme suit :
météo 30%, réglementation 20%, pilotage 20%, mécavol 20%, matériel 10%.

V: Brevet initial
B: Brevet pilote
M: Brevet confirme

N: Materiel
E: Mecavol
A: Meteo
W: Pilotage
S: Reglementation
 */

class Model {
  Model() {
    print('initializing the Model');

    loadAsset() async {
      final String dataFromCsv =
          await rootBundle.loadString("assets/data/data.csv");
      List<List<dynamic>> csvTable =
          CsvToListConverter(fieldDelimiter: ',', eol: '\n')
              .convert(dataFromCsv);
      Model._data = csvTable;
      this._questionIndex = 1;
      Model._answersIndexes = [2, 4, 6, 8];
      Model._pointsIndexes = [3, 5, 7, 9];
    }

    loadAsset();
  }

  static List<List<dynamic>> _data;
  int _questionIndex;
  static List<int> _answersIndexes;
  static List<int> _pointsIndexes;
  static List<int> get answersIndexes => _answersIndexes;
  static List<List<dynamic>> _currentQuiz;
  static Map _csvPrefixes = {
    'général': ['A-Z'],
    'météo': ['A'],
    'règlementation': ['S'],
    'mécavol': ['E'],
    'matériel': ['E']
  };
  static Map _csvSuffixes = {
    'brevet initial': ['V'],
    'brevet de pilote': ['B'],
    'brevet de pilote confirmé': ['M'],
    'tous': ['A-Z']
  };

  static String getQuestion(int index) {
    return _currentQuiz[index][1];
  }

  static List<String> getAnswers(int index) {
    return _answersIndexes
        .map((answerIndex) => _currentQuiz[index][answerIndex].toString())
        .toList();
  }

  static void initializeQuiz(String theme, String level, int length) {
    final prefix = _csvPrefixes[theme];
    final suffix = _csvSuffixes[level];
    final regex = new RegExp("${prefix}.*${suffix}");
    // final regex = new RegExp(r'${prefix}.*${suffix}');
    final questionsList = _data.where((row) => regex.hasMatch(row[0])).toList();
    List<int> randomIndexes = new List<int>.generate(
        questionsList.length, (int index) => index); // [0, 1, 4]
    randomIndexes.shuffle();
    // _currentQuiz =
    _currentQuiz = randomIndexes
        .sublist(length)
        .map((index) => questionsList[index])
        .toList();
  }

  static List<dynamic> getPoints(int index) {
    return _pointsIndexes
        .map((point) => _currentQuiz[index][point].toString())
        .toList();
  }
}
