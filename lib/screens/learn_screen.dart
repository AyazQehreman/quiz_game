import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/constants.dart';
import 'package:quiz_app/utils/utility.dart';

import 'home_screen.dart';

class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  String image;
  List tmpList = [0, 0, 0, 0, 0];
  int tmp;
  bool canPress = true; // Waiting 5 seconds before can change animals

  //Lists generated in Constants file and used static
  List<String> imagesList = Constants.imagesList;
  List<String> soundList = Constants.soundList;

  @override
  void initState() {
    super.initState();
    getImage();
    canPress = false;
  }

  // Design of screen
  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      image.substring(14).replaceAll('.png', '').toUpperCase(),
                      style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Image.asset('$image'),
                  ),
                  ElevatedButton(
                    child: Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NEXT',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: canPress ? Colors.black : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    onPressed: canPress ? getImage : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Getting image and text from list by random number
  void getImage()
  {
    canPress = false;

    setState(() {
      image = imagesList[Utility.getRandomNumber(
          'Learn Screen',
          Constants.imagesList.length)]; // Uses Utility class getRandomNumber method for creating image from list

      Utility.playAudio(soundList[Constants.numbers[Constants.numbers.length - 1]], true); // Play last selected sound from list of 8 items.
    });

    // Deactivate next button for N seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        canPress = true;
      });
    });
  }
}
