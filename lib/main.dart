import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:quickalert/quickalert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> icons = [];
int res = 0;
int total = 0;
  void result(bool resultValue){
    total++;
    if (resultValue){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Your answer is correct!',
      );
      res++;
    }else{
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, Your answer is not correct!',
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(index),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  print(quizBrain.lastquestion());
                  if (quizBrain.truecheck() && !quizBrain.lastquestion()){
                    icons.add(Icon(Icons.check, color: Colors.green));
                    result(true);
                  }else if((quizBrain.falsecheck() && !quizBrain.lastquestion())){
                    icons.add(Icon(Icons.close, color: Colors.red));
                    result(false);
                  }else if(quizBrain.lastquestion()){
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'your score is $res/$total',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      confirmBtnColor: Colors.green,
                    );
                    quizBrain.resetIndex();
                    icons = [];
                    res =0;
                    total=0;
                  }
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrain.falsecheck() && !quizBrain.lastquestion()){
                    icons.add(Icon(Icons.check, color: Colors.green));
                    result(true);
                  }else if (quizBrain.truecheck() && !quizBrain.lastquestion()){
                    icons.add(Icon(Icons.close, color: Colors.red));
                    result(false);
                  }else if(quizBrain.lastquestion()){
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'your score is $res/$total',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      confirmBtnColor: Colors.green,
                    );
                    quizBrain.resetIndex();
                    icons = [];
                    res =0;
                    total=0;
                  }
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: icons,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
