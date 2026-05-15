import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/home.dart';
import 'package:checkit/Pages/settings.dart';
import 'package:checkit/Pages/showTasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({
    Key? key,
    required this.openTaskPage,
    required this.openSettingsPage,
  }) : super(key: key);

  final bool openTaskPage;
  final bool openSettingsPage;

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  FireStore _fireStore = FireStore();

  String? displayNameCurrentUser =
      FirebaseAuth.instance.currentUser?.displayName;

  int _selectedPageIndex = 0;
  int _amountOfCheck = 0;

  DateTime _date = new DateTime.now();

  List<Widget> _pageOptions = <Widget>[
    HomePage(),
    ShowTasksPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.openTaskPage) {
      setState(() {
        _selectedPageIndex = 1;
      });
    }

    if (widget.openSettingsPage) {
      setState(() {
        _selectedPageIndex = 2;
      });
    }
  }

  void _onTappedNavigationItem(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<String> _fetchData() async {
    _amountOfCheck = await _fireStore.countNotDoneChecks(
      'Check',
      FirebaseAuth.instance.currentUser?.uid,
    );
    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: AppBar(
              toolbarHeight: 150,
              elevation: 0,
              backgroundColor: Color.fromARGB(0, 231, 143, 12),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getGreeting() +
                              " \n" +
                              (displayNameCurrentUser != null &&
                                      displayNameCurrentUser != ''
                                  ? displayNameCurrentUser!
                                  : ''),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.fontFamily,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image(
                                image: AssetImage(
                                    'assets/img/mewithoutbackground.png'),
                                height: 75),
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
                              fontSize: 20,
                            )),
                        _amountOfCheck > 1
                            ? Text(
                                _amountOfCheck.toString() + ' tasks to do!',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 54, 37, 37),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                _amountOfCheck.toString() + ' task to do!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
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
                  image: new ExactAssetImage('assets/img/try23.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: _pageOptions.elementAt(_selectedPageIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                color: Color.fromRGBO(233, 236, 233, 1),
                size: 22,
              ),
              selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
              selectedFontSize: 15.0,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.722),
              unselectedIconTheme: IconThemeData(
                color: Color.fromRGBO(233, 236, 233, 1),
                size: 22,
              ),
              elevation: 1.0,
              backgroundColor: Color.fromARGB(0, 0, 0, 25),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 25),
                  activeIcon: Icon(
                    Icons.home_outlined,
                    size: 35,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_outlined, size: 25),
                  activeIcon: Icon(
                    Icons.task_outlined,
                    size: 35,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined, size: 25),
                  activeIcon: Icon(
                    Icons.settings_outlined,
                    size: 35,
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedPageIndex,
              onTap: _onTappedNavigationItem,
            ),
          );
        } else if (snapshot.hasError) {
          return ListView(shrinkWrap: false, children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ]);
        } else {
          return ListView(shrinkWrap: false, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 30, 32, 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color.fromRGBO(255, 255, 255, 1),
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loading data...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 190, 76, 143),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);
        }
      },
    );
  }
}
