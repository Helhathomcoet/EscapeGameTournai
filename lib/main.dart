import 'package:escape_game_tournai/quiz_provider.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'team_name_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => QuizProvider()
              ..getStoredScore()
              ..getStoredAnsweredQuestions()),
      ],
      child: MaterialApp(
        title: "Nom d'équipe",
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromARGB(255, 237, 66, 66),
              secondary: const Color.fromARGB(255, 236, 234, 228)),
        ),
        home: Builder(builder: (context) {
          final quizProvider = Provider.of<QuizProvider>(context);
          final teamName = quizProvider.teamName;
          return teamName == '' ? TeamNameScreen() : HomePage();
        }),
      ),
    );
  }
}
