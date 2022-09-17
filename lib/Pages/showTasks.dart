import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Entities/MotherObject.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:flutter/material.dart';

import '../Entities/Check.dart';
import '../JsonThings/wrapper.dart';

class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<ShowTasksPage> createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  final _wrapper = Wrapper();

  MotherObject _motherObject = MotherObject();

  @override
  void initState() {
    super.initState();

    _getAvailableChecks();
  }

  void _getAvailableChecks() async {
    var result = await _wrapper.readUserWithData();

    setState(() {
      _motherObject = result;
    });
  }

  void _callCreateTask() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateTask()));

    var result = await _wrapper.readUserWithData();
    setState(() {
      _motherObject = result;
    });
  }

  void _callRemoveTask(Check checkToRemove) async {
    // var result = await _wrapper.executeUpdate(checkToRemove);
    // setState(() {
    //   _checkList.checkList = result;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // _getAvailableChecks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Theme.of(context).navigationBarTheme.indicatorColor,
              fontFamily: Theme.of(context).textTheme.bodyText2?.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyText2?.fontSize),
        ),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
            itemCount: _motherObject.checkList.checkList?.length,
            itemBuilder: (BuildContext context, int index) {
              if (_motherObject.checkList.checkList[index].done != true) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () => _callRemoveTask(
                        _motherObject.checkList.checkList[index]),
                    child: Card(
                      color: Theme.of(context).backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _motherObject.checkList.checkList[index].title
                              .makeFirstLetterCapitalize(),
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyText2?.fontSize,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.fontFamily,
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
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: _callCreateTask,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
