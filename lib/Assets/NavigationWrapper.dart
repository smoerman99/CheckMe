import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/home.dart';
import 'package:checkit/Pages/settings.dart';
import 'package:checkit/Pages/showTasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({Key? key}) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  FireStore _fireStore = FireStore();

  String? test = FirebaseAuth.instance.currentUser?.displayName;

  int _selectedPageIndex = 0;
  int _amountOfCheck = 0;

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
              backgroundColor: Color.fromARGB(188, 231, 143, 12),
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
                              (test != null && test != '' ? test! : ''),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.fontFamily,
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
                                image: AssetImage(
                                    'assets/img/mewithoutbackground.png'),
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
                        _amountOfCheck > 1
                            ? Text(_amountOfCheck.toString() + ' tasks to do!')
                            : Text(_amountOfCheck.toString() + ' task to do!',
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
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: _pageOptions.elementAt(_selectedPageIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                color: Color.fromRGBO(236, 235, 233, 1),
                size: 45,
              ),
              selectedItemColor: Color.fromRGBO(0, 0, 0, 0.722),
              selectedFontSize: 16.0,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.722),
              unselectedIconTheme: IconThemeData(
                color: Color.fromRGBO(236, 235, 233, 1),
                size: 30,
              ),
              elevation: 0.0,
              backgroundColor: Color.fromARGB(188, 231, 143, 12),
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
                        'Loading data.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2?.fontFamily,
                          fontSize: 25,
                          color: Color.fromRGBO(158, 177, 219, 1),
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
