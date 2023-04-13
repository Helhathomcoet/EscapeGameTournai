import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider extends ChangeNotifier {
  late String _teamName;
  late List<Question> _questions;

  String get teamName => _teamName;
  List<Question> get questions => _questions;
  int _score = 0;

  int get score => _score;

  QuizProvider() {
    _teamName = '';
    _questions = [
      Question(
        question:
            'Sur combien de pierre de plus en plus hautes faut-il marcher pour atteindre la porte du palais de justice ?',
        answer: '27',
        hint: 'Compter les marches',
        showHint: false,
      ),
      Question(
        question:
            'Vous ne devez pas vous y rendre si vous le voyez, donnez moi son nom. (pas sa profession)',
        answer: 'les filles d\'yeux',
        hint:
            'C\'est l\'ophtalmologue qui se situe entre le palais de justice et la cathédrale, donnez moi son nom',
        showHint: false,
      ),
      Question(
        question:
            'Je suis un peintre, figé dans la pierre, légérement surélevé,  quel est mon nom ?  ',
        answer: 'Gallait',
        hint: 'Je me situe parc Reine astrid',
        showHint: false,
      ),
      Question(
        question:
            'Quelle est la forme de la structure centrale du musée des beaux-arts ? (indice sur place)',
        answer: 'dodécagone',
        hint: 'Exemple type de réponse : octogone, hexagone, etc',
        showHint: false,
      ),
      Question(
        question:
            'De quel style est la belle demeure du centre de la marionnette ?',
        answer: 'néo-classique',
        hint: 'Information sur un panneau proche',
        showHint: false,
      ),
      Question(
        question:
            'Rendez-vous place Walter Ravez, de quoi suis un membre fondateur ?',
        answer: 'Cabaret Wallon',
        hint: 'Le papa de fox y chante',
        showHint: false,
      ),
      Question(
        question: 'Combien y-a-t il de cloche sur ce batiment ? (grand place)',
        answer: '31',
        hint: 'Faites attention aux vitrines et aux cotés du balcon',
        showHint: false,
      ),
      Question(
        question:
            'Quelle corporation à sur son blason un marteau et une pince ?',
        answer: 'Maréchalerie',
        hint: 'assets/questionBlason.png',
        showHint: false,
      ),
      Question(
        question:
            'On raconte des choses sur le portail d\'Occident, parmi qui était élu l\'évêque fou ? (c\'est indiqué autour de la cathédrale)',
        answer: 'Les enfants de coeur',
        hint: 'Indiqué sur le panneau avec pour titre "portail occidental"',
        showHint: false,
      ),
      Question(
        question:
            'Qu\'est-il écrit au-dessus du 10ème symbole sur la facade de l\'école des frères',
        answer: 'La lecture',
        hint: 'assets/questionSymbole.png',
        showHint: false,
      ),
      Question(
        question:
            'Quel date est inscrit sur la statue représentant 4 aveugles/marcheurs et un gamin ? (Autour de la cathédrale)',
        answer: '1906',
        hint:
            'C\'est écrit un peu en dessous de leurs pieds, et le dernier chiffre c\'est un 6',
        showHint: false,
      ),
      Question(
        question: 'Bonus : Combien y-a-t-il de marches aux beffroi ?',
        answer: '257',
        hint: 'Aller demander les nullos',
        showHint: false,
      ),
    ];
    _loadTeamName();
  }

  // Charger les questions et leur contenu

  Future<void> _loadTeamName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _teamName = prefs.getString('team_name') ?? '';
    notifyListeners();
  }

  void updateTeamName(String name) async {
    _teamName = name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('team_name', name);
    notifyListeners();
  }

  String getTeamName() {
    return _teamName;
  }

  Question getQuestion(int index) {
    return _questions[index];
  }

  // Mettre à jour le score
  Future<void> updateScore(int newScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', newScore);
    _score = newScore;
    notifyListeners();
  }

  Future<void> getStoredScore() async {
    final prefs = await SharedPreferences.getInstance();
    final storedScore = prefs.getInt('score') ?? 0;
    _score = storedScore;
    notifyListeners();
  }

  void saveAnsweredQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('answered_questions',
        _questions.toList().map((e) => e.answered.toString()).toList());
  }

  //get Stored Answered Questions
  Future<void> getStoredAnsweredQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> answeredQuestions =
        prefs.getStringList('answered_questions') ?? [];
    if (answeredQuestions.isNotEmpty) {
      for (int i = 0; i < answeredQuestions.length; i++) {
        if (answeredQuestions[i] == 'true') {
          _questions[i].answered = true;
        } else {
          _questions[i].answered = false;
        }
      }
    }
    notifyListeners();
  }

  Future<void> answerQuestion(int index, String answer) async {
    if (_questions[index].answer.toLowerCase() == answer.toLowerCase()) {
      _questions[index].answered = true;
      updateScore(_score + 50);
    } else {
      _questions[index].answered = false;
      updateScore(_score - 3);
    }
    saveAnsweredQuestion();
    notifyListeners();
  }

  // Afficher le hint
  void showHint(Question question) {
    question.showHint = true;
    updateScore(_score - 20);
    notifyListeners();
  }

  void getAnswerQuestion(int index) {
    _questions[index].answered = true;
    notifyListeners();
  }
}
