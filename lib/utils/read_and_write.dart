import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class ReadAndWrite
{
  static String _appDocumentsDirectory;
  static File file;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    _appDocumentsDirectory =  directory.path;
    print("PATH : " + _appDocumentsDirectory.toString());
    return _appDocumentsDirectory;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/schedules.txt');
  }

  static Future<File> writeFile(String data) async {
    final file = await _localFile;
    // Write the file.
    print("writeToFile" + data.toString());
    return file.writeAsString('$data');
  }

  static Future<String> readFile() async {
    try {
      final file = await _localFile;
      // Read the file.
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return "For some reason can't read file.";
    }
  }



}