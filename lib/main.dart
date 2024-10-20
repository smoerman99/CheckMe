import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

// https://github.com/flutter/flutter/issues/17592

// adb handy
// https://stackoverflow.com/questions/37267335/android-studio-wireless-adb-error-10061

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Stream authenticateUserStream() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Check Me',
      theme: ThemeData(
        // iconTheme: IconThemeData(color: Colors.blueGrey, size: 22),
        //for the rest what needs a color
        hintColor: Color.fromRGBO(4, 24, 31, 1),
        primaryColor: Color.fromRGBO(4, 24, 31, 1),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: "Aptos",
            fontSize: 25.00,
          ),
          //for the rest
          bodyText2: TextStyle(
            color: Color.fromRGBO(113, 131, 165, 0.945),
            fontFamily: "Aptos",
            fontSize: 22.00,
          ),
          headline2: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: "Aptos",
            fontSize: 25.00,
            fontWeight: FontWeight.bold,
          ),
        ),

        //navigation scheme settings
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Color.fromRGBO(158, 177, 219, 1),
          indicatorColor: Colors.black,
        ),

        //styling for the buttons
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),

        //specific styling for cards
        cardTheme: CardTheme(),

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.orange, // Cursor color
          selectionColor: Colors.orange, // Color when text is selected
          selectionHandleColor: Colors.orange, // Handle color
        ),
      ),
      home: StreamBuilder(
        stream: authenticateUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erruerr"),
            );
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const SignInWidget();

              case ConnectionState.waiting:
                return const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );

              case ConnectionState.done:
                return const Text("done");

              case ConnectionState.active:
                if (snapshot.data == null) {
                  return const SignInWidget();
                } else {
                  return Container(
                    child: const NavigationWrapper(),
                  );
                }
            }
          }
        },
      ),
    );
  }
}
