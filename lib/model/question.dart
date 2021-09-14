class Question {
  String? question;
  String? answer;
  List<String>? options;

  Question(Map val) {
    question = val['question'];
    answer = val['correct_answer'];
    options = [...val['incorrect_answers'], val['correct_answer']];
    options!.shuffle();
  }
}
