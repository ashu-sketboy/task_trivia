import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:trivia/providers/google_sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:trivia/screens/home_screen.dart';
import 'package:trivia/screens/login_screen.dart';
import 'package:trivia/screens/quiz_screen.dart';

import 'package:trivia/providers/question_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trivia',
        theme: ThemeData.dark(),
        // initialRoute: HomeScreen.route,
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Something Went Wrong'),
                ),
              );
            } else if (snapShot.hasData) {
              // Navigator.pushNamed(context, HomeScreen.route);
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (stream.hasError) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Something Went Wrong'),
                      ),
                    );
                  } else if (stream.hasData) {
                    return HomeScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              );
              // return HomeScreen();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        // initialRoute: QuizScreen.route,
        routes: {
          HomeScreen.route: (_) => HomeScreen(),
          QuizScreen.route: (_) => QuizScreen(),
        },
      ),
    );
  }
}
