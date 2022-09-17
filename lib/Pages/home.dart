import 'package:checkit/Entities/User.dart';
import 'package:checkit/JsonThings/wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Wrapper _wrapper = Wrapper();

  User _user = User();

  // void initState() {
  //   _wrapper.
  // }

  @override
  Widget build(BuildContext context) {
    return Text("Hi" + _user.name);
  }
}
