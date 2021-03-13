import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/learn_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/test_screen.dart';
import 'file:///C:/Development/Projects/quiz_app/lib/utils/read_and_write.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    readHighScoreFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Center(
          child: SafeArea(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'FIND ANIMALS',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                ElevatedButton(
                  child: Text('Learn new animals'),
                  onPressed: () {
                    navigate(context, LearnScreen());
                  },
                ),
                ElevatedButton(
                  child: Text('Quess animals'),
                  onPressed: () {
                    navigate(context, QuizScreen());
                  },
                ),
                ElevatedButton(
                  child: Text('Test'),
                  onPressed: () {
                    navigate(context, TestScreen());
                  },
                ),
                SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  exitDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              title: Text(
                'Do you really want to leave us?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              onOkButtonPressed: () => SystemNavigator.pop(),
              image: Image.asset('assets/images/cat.png'),
              onCancelButtonPressed: () => Navigator.pop(context),
          buttonCancelColor: Colors.green,
          buttonOkColor: Colors.red,
            ));
  }
}
