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
      title: 'Check Me',
      theme: ThemeData(
        //main section
        //default background color for the app
        backgroundColor: Colors.black12,

        //for the rest what needs a color
        hintColor: Colors.black,

        primaryColor: const Color(0xffe0f2f1),

        //navigation scheme settings
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.blueGrey,
        ),

        //styling for the buttons
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),

        //specific styling for cards
        cardTheme: CardTheme(),
      ),
      home: ShowTasks(title: 'Tasks to do'),
    );
  }
}
