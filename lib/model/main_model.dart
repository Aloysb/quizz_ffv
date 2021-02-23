import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    }

    loadAsset();
  }

  static List<List<dynamic>> _data;
  int _questionIndex;
  static List<int> _answersIndexes;
  static List<int> get answersIndexes => _answersIndexes;

  static String getQuestion(int index) {
    return _data[index][1];
  }

  static List<String> getAnswers(int index) {
    return _answersIndexes
        .map((answerIndex) => _data[index][answerIndex].toString())
        .toList();
  }
}
