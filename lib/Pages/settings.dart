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
    return Column(
      children: [
        Text('settings screen from the pages list'),
        TextButton(
          onPressed: () {
            _authentication.signOut();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignInWidget()));
          },
          child: Text("Log uit!"),
        ),
      ],
    );
  }
}

// hier kunnen projecten worden toegevoegd waar taken aan gekoppeld kunnen worden.
// darkmode
// over hoeveel dagen herinneringen sturen regelen
