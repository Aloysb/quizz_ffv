class Question {
  final String id;
  final String question;
  final List<dynamic> answers;
  final List<dynamic> points;

  Question({this.id, this.question, this.answers, this.points});

  bool _isValidated = false;
  List<int> selectedAnswers = [];
  int index;

  void toggleAnswer(int answer_idx) {
    this.selectedAnswers.contains(answer_idx)
        ? this.selectedAnswers.remove(answer_idx)
        : this.selectedAnswers.add(answer_idx);
  }

  void validateAnswers() {
    this._isValidated = true;
  }
}
