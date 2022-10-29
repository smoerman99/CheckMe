import 'package:checkit/Entities/MotherObject.dart';
import 'package:checkit/JsonThings/Wrapper.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _textEditingController = TextEditingController();

  Wrapper _wrapper = Wrapper();

  MotherObject _user = MotherObject();

  @override
  void initState() {
    super.initState();

    _user = fetchData();
  }

  fetchData() async {
    // var result = await _wrapper.readUserWithData();
    // setState(() {
    //   _user = result;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(_user.name),
        ],
      ),
    );
  }
}
