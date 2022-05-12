import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'questions.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;

  Quiz(@required this.questions, @required this.answerQuestion,
      @required this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Question(
                questions[questionIndex]['questionText'].toString(),
              ),
              ...(questions[questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map((ctx) {
                return Answer(
                    () => answerQuestion(ctx['score']), ctx['text'] as String);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
