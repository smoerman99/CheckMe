import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Entities/MotherObject.dart';
import 'package:checkit/JsonThings/Wrapper_Firebase.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:flutter/material.dart';

import '../Entities/Check.dart';

class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key key, @required Wrapper wrapper})
      : _wrapper = wrapper,
        super(key: key);
  final Wrapper _wrapper;

  @override
  State<ShowTasksPage> createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  MotherObject _user;

  @override
  void initState() {
    super.initState();

    _getAvailableChecks();
  }

  void _getAvailableChecks() async {
    var result = await widget._wrapper.readUserWithData();

    setState(() {
      _user = result;
    });
  }

  void _callCreateTask() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateTaskPage()));

    var result = await widget._wrapper.readUserWithData();
    setState(() {
      _user = result;
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
    return _user == null ||
            _user.checkList == null ||
            _user.checkList.checkList.length == 0
        ? Container()
        : Container(
            color: Theme.of(context).backgroundColor,
            child: ListView.builder(
                itemCount: _user.checkList.checkList?.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_user.checkList.checkList[index].done != true &&
                      _user.checkList.checkList[index].title != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onDoubleTap: () =>
                            _callRemoveTask(_user.checkList.checkList[index]),
                        child: Card(
                          color: Theme.of(context).backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _user != null
                                ? Text(
                                    _user.checkList.checkList[index].title
                                        .makeFirstLetterCapitalize(),
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.fontSize,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.fontFamily,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    );
                  }
                  return Text("data");
                }),
          );
  }
}
