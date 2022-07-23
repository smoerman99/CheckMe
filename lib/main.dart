import 'package:flutter/material.dart';
import 'showTasks.dart';

// https://github.com/flutter/flutter/issues/17592

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 123',
      theme: ThemeData(
        //main section
        //default color the background
        backgroundColor: Colors.blueGrey,
        hintColor: Colors.black,

        //default button background color
        buttonColor: Colors.orange,
        fontFamily: "Lato",
        accentColor: const Color(0xffe0f2f1),

        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              //for the navigation
              bodyText1: TextStyle(
                color: Colors.orange,
                fontFamily: "Lato",
                fontSize: 25.00,
              ),
              //for the rest
              bodyText2: TextStyle(
                color: Colors.orange,
                fontFamily: "Lato",
                fontSize: 22.00,
              )),
        ),

        //specific styling for cards
        cardTheme: CardTheme(),
      ),
      home: ShowTasks(title: 'Tasks to do'),
    );
  }
}
