import 'package:checkit/Assets/StringThings.dart';
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

  DateTime _date = new DateTime.now();

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
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        elevation: 9,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(doSomething() + " \nSander",
                      style: TextStyle(color: Colors.black, fontSize: 32)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(14, 55, 98, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image(
                          image:
                              AssetImage('assets/img/mewithoutbackground.png'),
                          height: 50),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_date.day}-${_date.month}-${_date.year}",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  Text('16 task to do!',
                      style: TextStyle(color: Colors.black, fontSize: 18))
                ],
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/img/try11.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        // color: Color.fromRGBO(13, 32, 83, 0.8),
        child: _pageOptions.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme:
            IconThemeData(color: Color.fromRGBO(14, 55, 98, 1), size: 40),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.7),
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
