import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/quiz_by_names_screen.dart';
import 'package:quiz_app/screens/quiz_by_sounds_screen.dart';
import 'file:///C:/Development/Projects/quiz_app/lib/utils/read_and_write.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:quiz_app/utils/utility.dart';
import 'learn_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List colors = [];
  String learnScreenImage = 'assets/images/rabbit.png';
  String quizBySoundsScreenImage = 'assets/gifs/giraffe_head.gif';
  String quizByNamesScreenImage = 'assets/gifs/question.gif';

  bool isTimerActive = true;

  @override
  void initState() {
    super.initState();
    isTimerActive = true;
    readHighScoreFromFile();

    // Zero score and life
    Constants.lives = 3;
    Constants.score = 0;

    for (int i = 0; i < 5; i++) {
      colors.add(Utility.getRandomNumber(
          'Home screen colors', Constants.colorsList.length));
    }

    getNewImage();

    print(colors);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Utility.exitDialog(context,
            message: 'Do you really want to leave me?',
            okFunction: () => SystemNavigator.pop(),
            chancelFunction: () => Navigator.pop(context));
      }, //exitDialog(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header of home screen
            Text(
              'LEARN NEW THINGS',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Constants.colorsList[colors[0]],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createContainer(
                    //First and biggest container - button. Learn Screen //
                    width: 0.45,
                    height: 0.482,
                    borderRadius: 25.0,
                    color: Constants.colorsList[colors[1]],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 5, child: Image.asset(learnScreenImage)),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Learn new animals',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      isTimerActive = false;
                      Utility.navigate(context, LearnScreen());
                    }),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Column(
                  children: [
                    createContainer(
                        // Second container QuizBySounds //
                        width: 0.4,
                        height: 0.225,
                        borderRadius: 25.0,
                        color: Constants.colorsList[colors[2]],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //Image.asset('assets/gifs/giraffe_head.gif'),
                            Expanded(
                                flex: 4,
                                child: Image.asset(quizBySoundsScreenImage)),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Find by Sounds',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                )),
                          ],
                        ),
                        onTap: () {
                          isTimerActive = false;
                          Utility.navigate(context, QuizBySoundsScreen());
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    createContainer(
                        // Third Container quiz by names //
                        width: 0.4,
                        height: 0.225,
                        borderRadius: 25.0,
                        color: Constants.colorsList[colors[3]],
                        child: Column(
                          children: [
                            //Image.asset('assets/gifs/question.gif'),
                            Expanded(
                                flex: 4,
                                child: Image.asset(quizByNamesScreenImage)),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Find by Names',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                )),
                          ],
                        ),
                        onTap: () {
                          isTimerActive = false;
                          Utility.navigate(context, QuizByNamesScreen());
                        }),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            //At the bottom , showing HIGH SCORE
            createContainer(
              width: 0.9,
              height: 0.05,
              borderRadius: 25.0,
              color: Constants.colorsList[colors[4]],
              child: Center(
                child: BlinkText(
                  'HIGHEST SCORE: ${Constants.highScore}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  beginColor: Colors.white,
                  endColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createContainer(
      {double borderRadius,
      double width,
      double height,
      Color color,
      Widget child,
      Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 15.0,
                spreadRadius: 1.0,
                offset: Offset(5.0, 5.0),
              ),
            ]),
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        child: child,
      ),
    );
  }

  // Navigator function for home screen menu
  void navigate(BuildContext context, dynamic navigateToScreen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => navigateToScreen));
  }

  void readHighScoreFromFile() async {
    String tmp = await ReadAndWrite.readFile();
    setState(() {
      Constants.highScore = int.parse(tmp);
    });
  }

  void getNewImage() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      // createNewImage();
      learnScreenImage = Utility.createNewImage('Home screen');
      setState(() {});

      if (!isTimerActive) timer.cancel();
      print('Is timer active  - ' +
          isTimerActive.toString() +
          ' real timer - ' +
          timer.isActive.toString());
    });
  }
}
