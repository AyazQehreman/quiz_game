import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'file:///C:/Development/Projects/quiz_app/lib/utils/read_and_write.dart';
import 'package:quiz_app/utils/constants.dart';


class GameOverScreen extends StatefulWidget {

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool isHighScoreBeaten = false;

  @override
  void initState() {
    super.initState();

    isHighScoreBeaten = highScoreCheck();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'GAME OVER',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: Image.asset('assets/images/game_over.png')),

                  //If a score is a new record , show it as BLINK TEXT
                  isHighScoreBeaten ?
                  BlinkText('THIS IS A HIGHEST SCORE: ${Constants.highScore}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    beginColor: Colors.white,
                    endColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ) : Text(
                    'Your score is: ' + Constants.score.toString(),
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                    ),
                  ),

                  // Play again button
                  ElevatedButton(
                    child: Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PLAY AGAIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Icon(Icons.next_plan
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {

                      highScoreCheck();
                      Constants.score = 0;
                      Constants.lives = 3;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void writeScoreToFile(int score) async
  {
    await ReadAndWrite.writeFile(score.toString());
  }

  bool highScoreCheck()
  {
    setState(() {
    });

    if(Constants.score > Constants.highScore)
    {
      Constants.highScore = Constants.score;
      writeScoreToFile(Constants.highScore);
      return true;
    } else
      {
        return false;
      }
  }
}
