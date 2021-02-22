import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  static String getQuestion(int index) {
    return _data[index][1];
  }

  static List<String> getAnswers(int index) {
    _answersIndexes.map((answerIndex) => _data[index][answerIndex]);
  }
}
