import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

// adb handy
// https://stackoverflow.com/questions/37267335/android-studio-wireless-adb-error-10061

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for daily reminders',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      )
    ],
    // channelGroups: [
    //   NotificationChannelGroup(
    //       channelGroupKey: 'basic_channel_group',
    //       channelGroupName: 'Basic group')
    // ],
    debug: true,
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  scheduleDailyNotification();

  runApp(MyApp());
}

Future<int> _getAmountAndSendNotification() async {
  FireStore _fireStore = FireStore();

  return await _fireStore.countNotDoneChecks(
    'Check',
    FirebaseAuth.instance.currentUser?.uid,
  );
}

void scheduleDailyNotification() async {
  var _amountOfCheck = await _getAmountAndSendNotification();

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10, // Unique ID for the notification
      channelKey: 'basic_channel',
      title: 'Daily Reminder',
      body: 'Don"' "t forget your ${_amountOfCheck} remaining task(s)'",
      notificationLayout: NotificationLayout.Default,
      icon: 'resource://drawable/smallicon',
    ),
    // there is an utf time difference of 1 hour. so 11 hour = 12 hours
    schedule: NotificationCalendar(
      hour: 18, // 7 PM
      minute: 0,
      second: 0,
      repeats: true,
    ),
  );
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);

  Stream authenticateUserStream() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream authenticateUserStream() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // This widget is the root of your application.
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
          bodyLarge: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: "Aptos",
            fontSize: 25.00,
          ),
          //for the rest
          bodyMedium: TextStyle(
              color: Color.fromARGB(188, 231, 143, 12),
              fontFamily: "Aptos",
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.1),
          displayMedium: TextStyle(
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
