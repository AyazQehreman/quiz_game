import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/game_over_screen.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/utility.dart';
import 'congratulations_screen.dart';

class QuizBySoundsScreen extends StatefulWidget {
  @override
  _QuizBySoundsScreenState createState() => _QuizBySoundsScreenState();
}

// todo canPlay for sound playing when pressed

class _QuizBySoundsScreenState extends State<QuizBySoundsScreen> {
  List<String> imagesList = Constants.imagesList;
  List<String> soundList = Constants.soundList;
  String soundPath = '';

  List<String> images = ['', '', '', ''];
  int randomImage;

  // Separate answer for every image
  bool answer1 = true;
  bool answer2 = true;
  bool answer3 = true;
  bool answer4 = true;

  bool canPress = true; // For playing sound again,
  bool wrongAnswer = false; // For subtracting only one life per question

  double Y = 0.0;
  double opacity = 1.0;


  @override
  void initState() {
    super.initState();

    //Generates 4 random numbers as image addresses from assets/images
    imageGenerator();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height * 0.1;
    // double width = MediaQuery.of(context).size.width * 0.2;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Utility.exitDialog(
          context,
          message: 'Are you sure?',
          okFunction: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
          chancelFunction: () => Navigator.pop(context),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Question text - gets images name route and makes name from it.
              Text(
                'Which animals sound is it?',
                // Gets path and file name , leaves only name ,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image 1
                  GestureDetector(
                    onTap: () {
                      if (answer1) {
                        // If answer is true (default = true), it checks it to correct or wrong. If false, it does't let to tap it again.
                        answer1 = checkAnswer(images[0]);
                      } else {
                        return;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: quizImage(images[0], answer1),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  // Image 2
                  GestureDetector(
                    onTap: () {
                      if (answer2) {
                        // If answer is true (default = true), it checks it to correct or wrong. If false, it does't let to tap it again.
                        answer2 = checkAnswer(images[1]);
                      } else {
                        return;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: quizImage(images[1], answer2),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image 3
                  GestureDetector(
                    onTap: () {
                      if (answer3) {
                        // If answer is true (default = true), it checks it to correct or wrong. If false, it does't let to tap it again.
                        answer3 = checkAnswer(images[2]);
                      } else {
                        return;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          quizImage(images[2], answer3), //Image.asset(image3)),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  // Image 4
                  GestureDetector(
                    onTap: () {
                      if (answer4) {
                        // If answer is true (default = true), it checks it to correct or wrong. If false, it does't let to tap it again.
                        answer4 = checkAnswer(images[3]);
                      } else {
                        return;
                      }
                    },
                    child: quizImage(images[3], answer4),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Constants.score.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      // Play sound of question again //
                      child: GestureDetector(
                          child: Container(
                            // Play sound of question again //
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.225,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepOrange, width: 2.5),
                                borderRadius: BorderRadius.circular(150),
                                boxShadow: [
                                  BoxShadow(
                                    color: canPress
                                        ? Colors.lime
                                        : Colors.lightGreen,
                                    blurRadius: 25.0,
                                    spreadRadius: 5.0,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ]),
                            child: canPress ? Image.asset('assets/gifs/music.gif') : Image.asset('assets/gifs/notes.gif'),
                          ),
                          onTap: canPress ? playSound : stopSound),
                    ),

                    // Showing hearts - 5 or less
                    if (Constants.lives >= 4)
                      Row(
                        children: [
                          Opacity(
                            opacity: opacity,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              alignment: Alignment(0, Y),
                              width: 25.0,
                              height: 25.0,
                              child:
                                  Image.asset('assets/images/heart_full.png'),
                            ),
                          ),
                          Text(
                            ' x ${Constants.lives}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              height: 0.65,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          for (int i = 0; i < Constants.lives; i++)
                            Container(
                              width: 20.0,
                              height: 20.0,
                              child:
                                  Image.asset('assets/images/heart_full.png'),
                            ),
                          for (int i = 3 - Constants.lives; i > 0; i--)
                            Container(
                              width: 20.0,
                              height: 20.0,
                              child:
                                  Image.asset('assets/images/heart_empty.png'),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Design of images showing on the screen
  Widget quizImage(String image, bool answer) {
    return Opacity(
      opacity: answer ? 1 : 0,
      child: Hero(
        tag: image,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset(image)),
      ),
    );
  }

  // todo try to use Utility class
  void imageGenerator() {
    Random randomNumber = Random();
    int number;
    answer1 = answer2 = answer3 = answer4 = true;

    for (int i = 0; i < 4; i++) {
      number = Utility.getRandomNumber(
          'Quiz By Sound Screen ', Constants.imagesList.length);
      images[i] = imagesList[number];
    }

    print('*********** ' + Constants.numbers.toString());

    setState(() {
      // Getting one of 4 images as a correct answer
      randomImage = randomNumber.nextInt(4);
      //Saving correct answer for passing Congratulations screen
      Constants.correctAnswer = images[randomImage];
      soundPath = Constants.correctAnswer
          .replaceAll('.png', '.mp3'); // assets/images/zebra.png
      soundPath = soundPath.replaceAll('images', 'sounds');
      Utility.playAudio(soundPath, true);

      print(soundPath);
    });
  }

  // Checking answers - Gets tapped images path to file and equals it correct answers.
  bool checkAnswer(String answer) {
    setState(() {});
    //Check tapped images path to path of correct answer
    if (images[randomImage] == answer) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CongratulationsScreen(pageNumber: 1)));
      return true;
    } else {
      //Playing audio of wrong answer
      Utility.playAudio('assets/sounds/wrong_answer.wav', true);

      //Minus the live if answer is incorrect
      subtractALife();

      Constants.mistakes++;
      if (Constants.lives <= 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GameOverScreen()));
      }
      return false;
    }
  }

  //Minus the live if answer is incorrect
  void subtractALife() {
    if (!wrongAnswer) {
      Constants.lives--;
      Constants.correctAnswerStreak = 0;
      wrongAnswer = true;

      Timer.periodic(Duration(milliseconds: 50), (timer) {
        setState(() {
          Y += 50;
          //opacity -= 0.1;
        });
        if (Y >= 1000) {
          timer.cancel();
          Y = 0.0;
          opacity = 0.0;
        }
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          opacity = 1.0;
        });
      });
    }
  }

  void playSound()
  {
    Utility.playAudio(soundPath, true);

    setState(() {

      canPress = false;

      Timer(Duration(seconds: 6), () {
        setState(() {
          canPress = true;
        });
      });
    });
  }

  void stopSound(){
    Utility.playAudio(soundPath, false);
  }


}
