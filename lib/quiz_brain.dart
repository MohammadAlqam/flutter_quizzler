import 'dart:ffi';

import 'package:quizzler/main.dart';

import 'question.dart';
var index = 0;
class QuizBrain{
  List<Question> _questions = [
    Question('What is your name', true),
    Question('How old are you', false),
    Question('Are you single',false),
    Question('Good Job',false)

  ];

  bool lastquestion(){
    if (index < _questions.length -1){
      return false;
    }else{
      return true;
    }
  }

  String getQuestion(int number){
    return _questions[number].questionText;
  }

  void nextQuestion(){
    if (index < _questions.length - 1){
        index++;
      }
    }

  bool truecheck(){
    if (_questions[index].answerText == true){
      return true;
    }else{
      return false;
    }
  }


  bool falsecheck(){
    if (_questions[index].answerText == false){
      return true;
    }else{
      return false;
  }
  }

  bool getAnswer(int number){
    return _questions[number].answerText;
  }

  void resetIndex(){
    index = 0;
  }

}

