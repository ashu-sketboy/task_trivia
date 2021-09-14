import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trivia/providers/google_sign_in_provider.dart';

import 'package:trivia/services/api_provider.dart' show Status;

import 'package:trivia/providers/question_provider.dart';

import 'package:trivia/screens/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home_screen';
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tivia'),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .googleLogOut();
            },
            child: const Text('Log Out'),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 65,
              // child: Icon(Icons.verified_user),
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(user.displayName!),
            const Spacer(),
            Consumer(
              builder: (context, QuestionProvider qp, _) {
                if (qp.status == Status.Loading) {
                  return const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  );
                } else {
                  return InkWell(
                    onTap: () async {
                      await qp.getQuestions();
                      if (qp.status == Status.Error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong'),
                          ),
                        );
                        return;
                      }

                      Navigator.pushNamed(context, QuizScreen.route);
                    },
                    child: const Icon(
                      Icons.play_circle_sharp,
                      size: 50,
                      color: Colors.green,
                    ),
                  );
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
