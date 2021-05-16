import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'constants.dart';

class Utility {
  static int getRandomNumber(String functionName, int range) {
    Random randomNumber = Random();

    int number = randomNumber.nextInt(range);

    if (!Constants.numbers.contains(number)) {
      Constants.numbers[0] = Constants.numbers[1];
      Constants.numbers[1] = Constants.numbers[2];
      Constants.numbers[2] = Constants.numbers[3];
      Constants.numbers[3] = Constants.numbers[4];
      Constants.numbers[4] = Constants.numbers[5];
      Constants.numbers[5] = Constants.numbers[6];
      Constants.numbers[6] = Constants.numbers[7];
      Constants.numbers[7] = number;
      print('$functionName' + number.toString());
      return Constants.numbers[7];
    } else {
      number = getRandomNumber('$functionName', range);
    }
    return Constants.numbers[7];
  }

  static void playAudio(String sound, bool play) async {
    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    play ? assetsAudioPlayer.open(Audio(sound)) : assetsAudioPlayer.stop();
  }

  static void navigate(BuildContext context, dynamic navigateToScreen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => navigateToScreen));
  }

  static void exitDialog(
    BuildContext context, {
    String message,
    @required Function okFunction,
    @required Function chancelFunction,
  }) {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              title: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              image: Image.asset(createNewImage('Exit dialog')),
              onOkButtonPressed: okFunction,
              //onOkButtonPressed: () => SystemNavigator.pop(),
              onCancelButtonPressed: chancelFunction,
              //onCancelButtonPressed:Navigator.pop(context),
              buttonCancelColor: Colors.green,
              buttonOkColor: Colors.red,
            ));
  }

  static String createNewImage(String message) {
    return Constants
        .imagesList[getRandomNumber(message, Constants.imagesList.length)];
    //quizBySoundsScreenImage = Constants.gifsList[Utility.getRandomNumber('HomeScreen ', Constants.gifsList.length)];
    //quizByNamesScreenImage = Constants.gifsList[Utility.getRandomNumber('HomeScreen ', Constants.gifsList.length)];
  }
}
