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
  static List<int> _answersIndexes = [2, 4, 6, 8];
  static List<int> _pointsIndexes = [3, 5, 7, 9];
  static List<Question> _currentQuiz;
  static Map _csvPrefixes = {
    'all': ['A-Z'],
    'weather': ['A'],
    'rules': ['S'],
    'flight_physics': ['E'],
    'gear': ['E']
  };
  static Map _csvSuffixes = {
    'BI': ['V'],
    'BP': ['B'],
    'BPC': ['M'],
    'ALL': ['A-Z']
  };

  static const _optionsData = {
    'category': [
      {
        'image': 'assets/images/meteo.jpeg',
        'title': 'météo',
        'value': 'weather',
      },
      {
        'image': 'assets/images/mecavol.jpeg',
        'title': 'mécavol',
        'value': 'flight_physics',
      },
      {
        'image': 'assets/images/reglementation.jpg',
        'title': 'règlementation',
        'value': 'rules',
      },
      {
        'image': 'assets/images/materiel.jpeg',
        'title': 'matériel',
        'value': 'gear',
      },
      {
        'image': 'assets/images/exam.jpeg',
        'title': 'géneral',
        'value': 'all',
      },
    ],
    'question': [
      {
        'image': 'assets/images/10.jpeg',
        'title': '10 questions',
        'value': '10',
      },
      {
        'image': 'assets/images/30.jpeg',
        'title': '30 questions',
        'value': '30',
      },
      {
        'image': 'assets/images/60.jpeg',
        'title': '60 questions',
        'value': '60',
      },
      {
        'image': 'assets/images/90.jpeg',
        'title': '90 questions',
        'value': '90',
      },
    ],
    'level': [
      {
        'image': 'assets/images/BI.jpg',
        'title': 'Brevet Initial',
        'value': 'BI',
      },
      {
        'image': 'assets/images/BP.jpeg',
        'title': 'Brevet Pilote',
        'value': 'BP',
      },
      {
        'image': 'assets/images/BPC.jpeg',
        'title': 'Brevet Confirmé',
        'value': 'BPC',
      },
      {
        'image': 'assets/images/ALL.jpeg',
        'title': 'Tous niveaux',
        'value': 'ALL',
      },
    ]
  };

  static optionData(String value) => _optionsData[value];

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
        .map((question_row) {
      String id = question_row[0].replaceAll(new RegExp("\D"), '').toString();
      String question = question_row[1].toString();

      List<String> answers = _answersIndexes
          .map((index) => question_row[index].toString())
          .toList()
          .where((question) => question != '')
          .toList();

      List<int> points = _pointsIndexes
          .map((index) {
            return question_row[index];
          })
          .toList()
          .whereType<int>()
          .toList();

      return Question(
          id: id, question: question, points: points, answers: answers);
    }).toList();

    return _currentQuiz;
  }
}
