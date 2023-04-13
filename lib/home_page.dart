import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';
import 'question_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final teamName = quizProvider.teamName;
    final score = quizProvider.score;
    final questions = quizProvider.questions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape XIII Tournai'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Equipe: $teamName\nScore: $score',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16.0),
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: questions
                  .asMap()
                  .map(
                    (index, question) => MapEntry(
                      index,
                      InkWell(
                        onTap: () {
                          if (question.answered) return;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  QuestionScreen(questionIndex: index),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: question.answered
                                ? const Color.fromARGB(255, 72, 143, 66)
                                : const Color.fromARGB(255, 131, 130, 127),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
