import 'package:checkit/createTask.dart';
import 'package:flutter/material.dart';

import 'Entities/Check.dart';
import 'Entities/CheckList.dart';
import 'JsonThings/wrapper.dart';

import 'Assets/StringThings.dart';

class ShowTasks extends StatefulWidget {
  const ShowTasks({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  final _wrapper = Wrapper();

  var _checkList = CheckList([]);

  @override
  void initState() {
    super.initState();

    _getAvailableChecks();
  }

  void _getAvailableChecks() async {
    var result = await _wrapper.executeRead();

    setState(() {
      _checkList.checkList = result;
    });
  }

  void _callCreateTask() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateTask()));

    var result = await _wrapper.executeRead();
    setState(() {
      _checkList.checkList = result;
    });
  }

  void _callRemoveTask(Check checkToRemove) async {
    var result = await _wrapper.executeUpdate(checkToRemove);
    setState(() {
      _checkList.checkList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getAvailableChecks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Theme.of(context).appBarTheme.textTheme.bodyText1.color,
              fontFamily:
                  Theme.of(context).appBarTheme.textTheme.bodyText1.fontFamily,
              fontSize:
                  Theme.of(context).appBarTheme.textTheme.bodyText1.fontSize),
        ),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: ListView.builder(
            itemCount: _checkList.checkList.length,
            itemBuilder: (BuildContext context, int index) {
              if (!_checkList.checkList[index].done) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () =>
                        _callRemoveTask(_checkList.checkList[index]),
                    child: Card(
                      color: Theme.of(context).backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _checkList.checkList[index].title
                              .makeFirstLetterCapitalize(),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .bodyText2
                                .fontSize,
                            fontFamily: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .bodyText2
                                .fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return null;
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: _callCreateTask,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
