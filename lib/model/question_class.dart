class Question {
  final String id;
  final String question;
  final List<String> answers;
  final List<int> points;

  Question({this.id, this.question, this.answers, this.points});

  bool _isValidated = false;
  List<int> selectedAnswers = [];
  int index;

  void toggleAnswer(int answer_idx) {
    this.selectedAnswers.contains(answer_idx)
        ? this.selectedAnswers.remove(answer_idx)
        : this.selectedAnswers.add(answer_idx);
  }

  int validateAnswers() {
    this._isValidated = true;

    //If less than 0, return 0
    print(this._calculatedPoints());
    return this._calculatedPoints() > 0 ? this._calculatedPoints() : 0;
  }

  int _calculatedPoints() {
    //If not answers selected, return 0
    if (this.selectedAnswers.length == 0) return 0;

    return this
        .selectedAnswers
        .map((answerIndex) => points[answerIndex])
        .toList()
        .reduce((a, b) => a + b);
  }

  bool isValidated() {
    return _isValidated;
  }
}
