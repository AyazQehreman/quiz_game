import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'constants.dart';

class Utility
{
  static int getRandomNumber() {
    Random randomNumber = Random();
    int number = randomNumber.nextInt(Constants.imagesList.length);

    if (!Constants.numbers.contains(number)) {
      Constants.numbers[0] = Constants.numbers[1];
      Constants.numbers[1] = Constants.numbers[2];
      Constants.numbers[2] = Constants.numbers[3];
      Constants.numbers[3] = Constants.numbers[4];
      Constants.numbers[4] = Constants.numbers[5];
      Constants.numbers[5] = Constants.numbers[6];
      Constants.numbers[6] = Constants.numbers[7];
      Constants.numbers[7] = number;
      Constants.allNumbers.add(number);


      print('^^^^^^^^^^^ ' + number.toString());
    } else {
      number = getRandomNumber();
    }
    return Constants.numbers[7];
  }

  static void playAudio(String sound) async {
    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio(sound),
    );
  }

}