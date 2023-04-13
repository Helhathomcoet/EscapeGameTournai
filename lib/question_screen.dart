import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'question.dart';
import 'quiz_provider.dart';

class QuestionScreen extends StatefulWidget {
  final int questionIndex;

  QuestionScreen({required this.questionIndex});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Question _question;

  @override
  void initState() {
    super.initState();
    _question = Provider.of<QuizProvider>(context, listen: false)
        .getQuestion(widget.questionIndex);
  }

  void _submitAnswer(String answer) {
    Provider.of<QuizProvider>(context, listen: false)
        .answerQuestion(widget.questionIndex, answer);
    if (QuizProvider().questions[widget.questionIndex].answer.toLowerCase() ==
        answer.toLowerCase()) {
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Mauvaise réponse"),
            content: const Text(
                "Attention, vous perdez 3 points par mauvaise réponse !"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final answerController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Question ${widget.questionIndex + 1}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  _question.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  controller: answerController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Réponse',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _submitAnswer(answerController.text),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    fixedSize: const Size(200, 50),
                  ),
                  child: const Text(
                    "Valider",
                    textScaleFactor: 1.6,
                  ),
                ),
                const SizedBox(height: 80.0),
                ElevatedButton(
                    onPressed: (() => {
                          setState(() {
                            if (_question.showHint == false) {
                              Provider.of<QuizProvider>(context, listen: false)
                                  .showHint(_question);
                            }
                          })
                        }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.black,
                      fixedSize: const Size(100, 40),
                    ),
                    child: const Text("Indice")),
                const SizedBox(height: 10),
                if (_question.showHint && !_question.hint.contains(".png"))
                  Text(_question.hint)
                else if (_question.showHint && _question.hint.contains(".png"))
                  Image.asset(_question.hint),
              ],
            ),
          ),
        ));
  }
}
