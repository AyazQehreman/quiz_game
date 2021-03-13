import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Development/Projects/quiz_app/lib/utils/read_and_write.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LEARN NEW THINGS',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createContainer(
                    width: 0.45,
                    height: 0.482,
                    borderRadius: 25.0,
                    color: Colors.red),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Column(
                  children: [
                    createContainer(
                        width: 0.4,
                        height: 0.225,
                        borderRadius: 25.0,
                        color: Colors.red),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    createContainer(
                        width: 0.4,
                        height: 0.225,
                        borderRadius: 25.0,
                        color: Colors.red,
                    child: Image.asset('assets/images/question.gif'),),
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
              height: 0.1,
              borderRadius: 25.0,
              color: Colors.red,
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
    );
  }

  Widget createContainer(
      {double borderRadius,
      double width,
      double height,
      Color color,
      Widget child}) {
    return Container(
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
