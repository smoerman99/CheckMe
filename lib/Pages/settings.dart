import 'package:checkit/Firebase/Auth.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

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
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('settings screen from the pages list'),
            Text('hier kunnen nieuwe projecten aangemaakt worden'),
            Text(
                'bij create task een tussen pagina waarin je een soort activiteit selecteerd met daarbij mooie icons'),
            Text('stel in na hoeveel tijd je een reminder wilt hebben'),
            TextButton(
              onPressed: () {
                _authentication.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignInWidget()));
              },
              child: Text("Log uit!"),
            ),
          ],
        ),
      ),
    );
  }
}

// hier kunnen projecten worden toegevoegd waar taken aan gekoppeld kunnen worden.
// darkmode
// over hoeveel dagen herinneringen sturen regelen
