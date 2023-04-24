import 'dart:convert';
import 'dart:io';

import 'package:checkit/Entities/Check.dart';

import 'package:path_provider/path_provider.dart';

class Wrapper {
  String _fileName = 'NeededData.json';

  ///The private methods section
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _getDirPath();
    return File('$path/$_fileName');
  }

  Future<bool> _fileExists(String fileName) async {
    final path = await _getDirPath();

    return await File('$path/$_fileName').exists();
  }

  Future<void> _createNewFileIfNeeded() async {
    final path = await _getDirPath();
    new File('$path/$_fileName').create(recursive: true);
  }

  CheckList _prepareUserData(String content) {
    Map<String, dynamic> decode = jsonDecode(content);

    CheckList motherObject = CheckList();

    for (var i = 0; i < decode.length; i++) {
      motherObject.name = decode['name'];
      motherObject.mood = decode['mood'];
      motherObject.tasksEverCompleted = decode['tasksEverCompleted'];

      for (var j = 0; j < decode[i].length; j++) {
        motherObject.checkList.checkList.add(
          new Check(title: "1", done: false),
        );
      }
    }
    return motherObject;
  }

  ///

  ///The public methods section
  ///The needed functionalities
  ///Create User, Update User data, Create task, Delete Task
  Future<void> writeUser(user) async {
    if (await _fileExists(_fileName)) {
      final file = await _localFile;
      return file.writeAsString(user);
    } else {
      _createNewFileIfNeeded();
      writeUser(user);
    }
  }

  Future<void> updateUser(CheckList user) async {
    if (await _fileExists(_fileName)) {
      final file = await _localFile;

      final String content = await file.readAsString();

      MotherObject motherObject = _prepareUserData(content);

      motherObject.name = user.name;
      motherObject.mood = user.mood;

      writeUser(motherObject);
    } else {
      _createNewFileIfNeeded();
      updateUser(user);
    }
  }

  Future<MotherObject> readUserWithData() async {
    if (await _fileExists(_fileName)) {
      final file = await _localFile;

      final String content = await file.readAsString();

      if (content == "") {
        return MotherObject(
            name: "John Doe",
            mood: "Is doing nothing",
            tasksEverCompleted: 0,
            checkList: null);
      } else {
        return _prepareUserData(content);
      }
    } else {
      _createNewFileIfNeeded();
      readUserWithData();
    }

    return null;
  }

  Future<void> writeTask(Check task) async {}

  ///
}
