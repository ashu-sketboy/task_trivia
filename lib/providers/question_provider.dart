import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trivia/model/question.dart';

import 'package:trivia/services/api_provider.dart';

import 'package:trivia/screens/quiz_result_screen.dart';

class QuestionProvider with ChangeNotifier {
  double progressIndicator = 0.0;
  int questionNumber = 0;
  int correctAnswers = 0;
  Status status = Status.Success;
  List<Question>? data;

  void clearData() {
    questionNumber = 0;
    progressIndicator = 0.0;
    correctAnswers = 0;

    notifyListeners();
  }

  void incrementProgressIndicator() {
    progressIndicator += 0.1;
    notifyListeners();
  }

  void incrementQuestionIndex(String ans, BuildContext context) {
    if (ans == data![questionNumber].answer) {
      correctAnswers += 1;
    }
    if (questionNumber == 9) {
      incrementProgressIndicator();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => QuizResultScreen(
            score: correctAnswers,
          ),
        ),
      );
      return;
    }
    questionNumber += 1;
    incrementProgressIndicator();
    notifyListeners();
  }

  void clearProvider() {
    progressIndicator = 0.0;
    questionNumber = 0;
  }

  getQuestions() async {
    var response;

    status = Status.Loading;
    notifyListeners();

    response = await ApiProvider.get();

    if (response['status'] == 200) {
      print('inside questions success');
      status = Status.Success;

      if (response['body']['message'] == 'Data not found') {
        notifyListeners();
        return;
      }
      data = [];
      for (var i in response['body']['results']) {
        data!.add(Question(i));
        // data = data.add(q);
      }

      notifyListeners();
      return;
    } else if (response['status'] == 'No Connection') {
      status = Status.NetworkError;
      notifyListeners();
      return;
    } else {
      status = Status.Error;
      notifyListeners();
      print(
          'inside questions error ${response['status']}: ${response['body']}');
      return;
    }
  }
}
