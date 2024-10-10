import 'package:checkit/Firebase/Auth.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseAuthentication _authentication = FirebaseAuthentication();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView(children: [
        SizedBox(
          height: 90,
        ),
        SizedBox(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Settings screen from the pages list',
                    style: TextStyle(
                      color: Color.fromARGB(188, 231, 143, 12),
                    ),
                  ),
                  Text(
                    'bepaal hier na hoeveel tijd je een reminder wilt hebben.',
                    style: TextStyle(
                      color: Color.fromARGB(188, 231, 143, 12),
                    ),
                  ),
                  Text(
                    'Zie Github project bord voor de openstaande taken',
                    style: TextStyle(
                      color: Color.fromARGB(188, 231, 143, 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _authentication.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInWidget()));
                    },
                    child: Text("Log uit!",
                        style: TextStyle(
                            color: Color.fromARGB(188, 231, 143, 12))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
