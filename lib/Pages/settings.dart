import 'package:checkit/Firebase/Auth.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //at some point you can change your username or password
  // TextEditingController _usernameEditingController = TextEditingController();
  // TextEditingController _passwordEditingController = TextEditingController();

  FirebaseAuthentication _authentication = FirebaseAuthentication();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 100 * 4,
          width: MediaQuery.of(context).size.width / 100 * 40,
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 100 * 30,
        width: MediaQuery.of(context).size.width / 100 * 85,
        child: Card(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            width: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Settings screen from the pages list',
                    style: TextStyle(
                      color: Color.fromRGBO(158, 177, 219, 1),
                    ),
                  ),
                  Text(
                    'bepaal hier na hoeveel tijd je een reminder wilt hebben.',
                    style: TextStyle(
                      color: Color.fromRGBO(158, 177, 219, 1),
                    ),
                  ),
                  Text(
                    'Zie Github project bord voor de openstaande taken',
                    style: TextStyle(
                      color: Color.fromRGBO(158, 177, 219, 1),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _authentication.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInWidget()));
                    },
                    child: Text("Log uit!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
