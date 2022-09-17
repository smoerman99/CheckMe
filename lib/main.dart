import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:flutter/material.dart';

// https://github.com/flutter/flutter/issues/17592

// adb handy
// https://stackoverflow.com/questions/37267335/android-studio-wireless-adb-error-10061

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
        backgroundColor: Colors.grey,

        //for the rest what needs a color
        hintColor: Color.fromRGBO(4, 24, 31, 1),

        primaryColor: Color.fromRGBO(4, 24, 31, 1),

        // rgb(40, 112, 148)

        textTheme: const TextTheme(
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
          ),
        ),

        //navigation scheme settings
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Color.fromRGBO(1, 50, 70, 1),
          indicatorColor: Colors.white,
        ),

        //styling for the buttons
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),

        //specific styling for cards
        cardTheme: CardTheme(),
      ),
      home: NavigationWrapper(),
    );
  }
}
