import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<_MyApp> {
  static const _questions = [
    {
      'questionText': 'When did Singapore gain independance?',
      'answers': [
        {'text': '1922', 'score': 0},
        {'text': '1989', 'score': 0},
        {'text': '1969', 'score': 0},
        {'text': '1965', 'score': 10},
      ]
    },
    {
      'questionText': 'Who was the first president of Singapore?',
      'answers': [
        {'text': 'Devan Nair', 'score': 0},
        {'text': 'Yusof Ishak', 'score': 10},
        {'text': 'Tony Tan', 'score': 0},
        {'text': 'Benjamin Sheares', 'score': 0},
      ]
    },
    {
      'questionText': 'What is the national flower of Singapore?',
      'answers': [
        {'text': 'Rose', 'score': 0},
        {'text': 'Cactus', 'score': 0},
        {'text': 'Orchid', 'score': 10},
        {'text': 'Sunflower', 'score': 0},
      ]
    },
    {
      'questionText': 'What is the national animal of Singapore?',
      'answers': [
        {'text': 'Otter', 'score': 0},
        {'text': 'Lion', 'score': 10},
        {'text': 'Goldfish', 'score': 0},
        {'text': 'Flamingo', 'score': 0},
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    setState(() {
      _totalScore = _totalScore + score;
      _questionIndex += 1;
      print(_questionIndex);
    });
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[300]),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {},
            ),
          ],
          title: Text("Quiz App"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                _questions,
                _answerQuestion,
                _questionIndex,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
