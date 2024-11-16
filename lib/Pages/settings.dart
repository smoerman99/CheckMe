import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:checkit/Firebase/Auth.dart';
import 'package:checkit/Widgets/Auth/signin.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseAuthentication _authentication = FirebaseAuthentication();
  final TextEditingController _displayNameController = TextEditingController();

  void getNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: 'Hello World!',
      body: 'This is my first notification!',
      icon: 'resource://drawable/testicon',
    ));
  }

  //this function needs to be fixed
  Future<void> _updateDisplayName(String dispalyName) async {
    setState(() {
      _displayNameController.text = '';
    });

    await _authentication.updateDisplayName(dispalyName);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView(children: [
        ElevatedButton(
          onPressed: getNotification, // Attach the function to the button
          child: Text('Press Me'),
        ),
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
                  TextFormFieldWithStyling(
                    needsExpanding: false,
                    hintText: 'New display name',
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    taskNameController: _displayNameController,
                    textInputType: TextInputType.text,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 119, 110, 96)),
                    ),
                    onPressed: () async {
                      await _updateDisplayName(_displayNameController.text);
                    },
                    child: Text(
                      'update display name',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 17,
                        backgroundColor: Color.fromARGB(255, 119, 110, 96),
                      ),
                    ),
                  ),
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
