import 'package:checkit/Pages/home.dart';
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Check It"),
            Image(
                image: AssetImage('assets/img/mewithoutbackground.png'),
                height: 50),
          ],
        ),
        backgroundColor: Color(0x44000000),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/img/try10.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        // color: Color.fromRGBO(13, 32, 83, 0.8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: _pageOptions.elementAt(_selectedPageIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.greenAccent, size: 33),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(backgroundColor: Color(0x44000000)),
        elevation: 0.0,
        backgroundColor: Color(0x00ffffff),
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
