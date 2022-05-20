import 'dart:convert';
import 'dart:io';

import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/CheckList.dart';
import 'package:path_provider/path_provider.dart';

class Wrapper {
  // -- Attribute
  CheckList _availableToChecks = new CheckList([]);

  String _fileName = "tasksV3.json";

  // -- To execute the read and write
  Future<List<Check>> executeRead() async {
    if (await _fileExists(_fileName)) {
      return await _readAvailableChecks();
    }

    await _createNewFileIfNeeded();
    return await _readAvailableChecks();
  }

  void executeWrite(Check newItem) async {
    if (await _fileExists(_fileName)) {
      await _gatherAndAdd(newItem);
      return;
    }

    await _createNewFileIfNeeded();
    await _gatherAndAdd(newItem);
  }

  Future<List<Check>> executeUpdate(Check toUpdateCheck) async {
    _availableToChecks.checkList = await _readAvailableChecks();

    _availableToChecks.checkList
        .removeWhere((item) => item.title == toUpdateCheck.title);

    _writeNewCheck(_availableToChecks);
    return await _readAvailableChecks();
  }

  // -- The needed functionalities
  Future<void> _gatherAndAdd(Check newItem) async {
    _availableToChecks.checkList = await _readAvailableChecks();

    _availableToChecks.checkList.add(newItem);

    _writeNewCheck(_availableToChecks);
  }

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

  Future<File> _writeNewCheck(newCheck) async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode(newCheck));
  }

  Future<List<Check>> _readAvailableChecks() async {
    CheckList _returnAvailableCheckItems = new CheckList([]);

    try {
      final file = await _localFile;

      final String contents = await file.readAsString();

      if (contents == "") {
        return _returnAvailableCheckItems.checkList;
      }

      Map<String, dynamic> decode = jsonDecode(contents);

      for (var i = 0; i < decode['checkItems'].length; i++) {
        _returnAvailableCheckItems.checkList.add(new Check(
            decode['checkItems'][i]["title"], decode['checkItems'][i]["done"]));
      }

      return _returnAvailableCheckItems.checkList;
    } catch (e) {
      return null;
    }
  }
}
