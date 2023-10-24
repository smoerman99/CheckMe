import 'package:checkit/Pages/settings.dart';
import 'package:checkit/Pages/showTasks.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key key}) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedPageIndex = 0;

  List<Widget> _pageOptions = <Widget>[
    Text('Here comes the home page with some facts!'),
    ShowTasksPage(),
    SettingsPage()
    // HomePage(wrapper: Wrapper()),
    // ShowTasksPage(wrapper: Wrapper()),
    // SettingsPage()
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
        elevation: 0,
        title: Text("Check It"),
        backgroundColor: Color.fromARGB(255, 121, 62, 62),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color.fromRGBO(13, 32, 83, 0.8),
        child: _pageOptions.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
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
        ],
        currentIndex: _selectedPageIndex,
        onTap: _onTappedNavigationItem,
      ),
    );
  }
}
