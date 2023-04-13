import 'package:escape_game_tournai/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';

class TeamNameScreen extends StatefulWidget {
  @override
  _TeamNameScreenState createState() => _TeamNameScreenState();
}

class _TeamNameScreenState extends State<TeamNameScreen> {
  final TextEditingController _teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nom de l\'équipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Entrez le nom de votre équipe :'),
            TextField(
              controller: _teamNameController,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                quizProvider.updateTeamName(_teamNameController.text);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
