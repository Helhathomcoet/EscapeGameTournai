class Question {
  String question;
  String answer;
  bool answered;
  String hint;
  bool showHint;

  Question({
    required this.question,
    required this.answer,
    required this.hint,
    required this.showHint,
    this.answered = false,
  });

  bool isQuestionAnswered() {
    return answered;
  }

  void setQuestionAnswered() {
    answered = true;
  }
}
