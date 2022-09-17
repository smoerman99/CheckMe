import 'package:checkit/Pages/home.dart';
import 'package:checkit/Pages/settings.dart';
import 'package:checkit/Pages/showTasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key key}) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedPageIndex = 0;

  static const List<Widget> _pageOptions = <Widget>[
    HomePage(),
    ShowTasksPage(),
    SettingsPage()
  ];

  void _onTappedNavigationItem(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks to do!"),
      ),
      body: Container(
        child: _pageOptions.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ]),
    );
  }
}
