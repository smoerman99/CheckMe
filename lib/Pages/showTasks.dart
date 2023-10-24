import 'package:checkit/Firebase/Firestore.dart';
import 'package:flutter/material.dart';
import '../Entities/Check.dart';

class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key key}) : super(key: key);

  @override
  State<ShowTasksPage> createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  FireStore _fireStore = FireStore();
  List<Check> _checks;
  String title;

  @override
  void initState() {
    super.initState();

    _getAvailableChecks();
  }

  void _getAvailableChecks() async {
    var result = await _fireStore.read('Check', 'uF3MCELOIFHI4ZkajOj1');
    // var result = await _fireStore.readAll('Check');

    setState(() {
      title = result.entries.elementAt(4).value;
      print(title);
    });
  }

  void _callCreateTask() async {
    // await Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => CreateTaskPage()));

    // var result = await widget._wrapper.readUserWithData();
    // setState(() {
    //   _user = result;
    // });
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
    return Column(
      children: [
        title != null ? Text(title) : Text('data'),
        TextButton(
            onPressed: _getAvailableChecks,
            child: Text('testging this button')),
      ],
    );
  }
}
