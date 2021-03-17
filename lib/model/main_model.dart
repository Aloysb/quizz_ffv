import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

import 'package:quizz_ffvl/model/question_class.dart';

/*
NOTE:
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
  //Constructor
  Model() {
    print('initializing the Model');

    //Load all the questions from the csv
    loadAsset() async {
      final String dataFromCsv =
          await rootBundle.loadString("assets/data/data.csv");
      List<List<dynamic>> csvTable =
          CsvToListConverter(fieldDelimiter: ',', eol: '\n')
              .convert(dataFromCsv);
      Model._data = csvTable;
    }

    loadAsset();
  }

  static List<List<dynamic>> _data;
  int _questionIndex;
  static List<int> _answersIndexes;
  static List<int> _pointsIndexes;
  static List<int> get answersIndexes => _answersIndexes;
  static List<Question> _currentQuiz;
  static Map _csvPrefixes = {
    'général': ['A-Z'],
    'météo': ['A'],
    'règlementation': ['S'],
    'mécavol': ['E'],
    'matériel': ['E']
  };
  static Map _csvSuffixes = {
    'BI': ['V'],
    'BP': ['B'],
    'BPC': ['M'],
    'ALL': ['A-Z']
  };

  static Question getQuestion(int index) {
    return _currentQuiz[index];
  }

  static List<Question> initializeQuiz(String theme, String level, int length) {
    final prefix = _csvPrefixes[theme];
    final suffix = _csvSuffixes[level];
    final regex = new RegExp("${prefix}.*${suffix}");

    final questionsList = _data.where((row) => regex.hasMatch(row[0])).toList();

    List<int> randomIndexes = new List<int>.generate(
        questionsList.length, (int index) => index); // [0, 1, 4]

    randomIndexes.shuffle();
    _currentQuiz = randomIndexes
        .sublist(0, length + 1)
        .map((index) => questionsList[index])
        .toList()
        .map((question) {
      String id = question[0].replaceAll(new RegExp("\D"), '');
      String question_question = question[1];
      List<dynamic> answers =
          _answersIndexes.map((index) => question[index]).toList();
      List<dynamic> points =
          _pointsIndexes.map((index) => question[index]).toList();

      return Question(
          id: id,
          question: question_question,
          points: points,
          answers: answers);
    }).toList();
  }
}
