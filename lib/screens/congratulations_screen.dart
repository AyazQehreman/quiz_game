import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/utility.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class CongratulationsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    Utility.playAudio('assets/sounds/correct_answer.mp3'); // Play winning audio
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/congratulations.png'),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Hero(
                    tag: Constants.correctAnswer,
                    child: Image.asset(Constants.correctAnswer),
                  ),
                ),
                ElevatedButton(
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('NEXT',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  onPressed: () {
                    calculateScore(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 1.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

// Calculating score by adding 10 for every correct answer and subtracting 3 * mistakes count
void calculateScore(BuildContext context) {
  Constants.score += (10 - Constants.mistakes * 3);
  Constants.correctAnswerStreak++;
  if(Constants.correctAnswerStreak == 5)
    {
      Constants.lives++;
      Toast.show("You got an EXTRA LIFE!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      Constants.correctAnswerStreak = 0;
    }
  Constants.mistakes = 0;
}
