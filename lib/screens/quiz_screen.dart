import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trivia/providers/question_provider.dart';

class QuizScreen extends StatelessWidget {
  static const String route = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer(
              builder: (context, QuestionProvider qp, _) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      minHeight: 10,
                      value: qp.progressIndicator,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    const Spacer(),
                    Text(
                      qp.data![qp.questionNumber].question!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ...qp.data![qp.questionNumber].options!.map((String e) =>
                        InkWell(
                          onTap: () => qp.incrementQuestionIndex(e, context),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(e),
                          ),
                        )),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
