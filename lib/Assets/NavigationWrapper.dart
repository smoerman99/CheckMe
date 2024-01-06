import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Pages/home.dart';
import 'package:checkit/Pages/settings.dart';
import 'package:checkit/Pages/showTasks.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key? key}) : super(key: key);

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
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 150,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getGreeting() + " \nSander",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1?.fontFamily,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image(
                          image:
                              AssetImage('assets/img/mewithoutbackground.png'),
                          height: 60),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  Text('16 task to do!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ))
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
            image: new ExactAssetImage('assets/img/try19.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _pageOptions.elementAt(_selectedPageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 40,
        ),
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
