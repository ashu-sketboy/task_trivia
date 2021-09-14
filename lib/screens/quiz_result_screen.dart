import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trivia/providers/question_provider.dart';

class QuizResultScreen extends StatelessWidget {
  int? score;

  QuizResultScreen({this.score = 0});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5),
      () {
        Provider.of<QuestionProvider>(context, listen: false).clearData();
        Navigator.of(context).pop();
      },
    );
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Result: $score/10',
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
