import 'package:checkit/Entities/MotherObject.dart';
import 'package:checkit/JsonThings/wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Wrapper _wrapper = Wrapper();

  MotherObject _user = MotherObject();

  void initState() {
    _wrapper.readUserWithData();
  }

  @override
  Widget build(BuildContext context) {
    if (_user.name != null) {
      return Text("Hi" + _user.name);
    }

    return Text("Hi");
  }
}
