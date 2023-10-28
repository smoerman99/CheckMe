import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Assets/NavigationWrapper.dart';

class SmallPhoneLayout extends StatelessWidget {
  const SmallPhoneLayout({Key key}) : super(key: key);

  Stream authenticateUserStream() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepPurple[200],
      body: StreamBuilder(
        stream: authenticateUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erruer"),
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
                  return const NavigationWrapper();
                }
            }

            return Text('NOT GOOD');
          }
        },
      ),
    );
  }
}
