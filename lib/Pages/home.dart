import 'package:checkit/Assets/GetBibleVerses.dart';
import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Entities/DailyVerse.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import '../Widgets/categoryContainer.dart';

//https://pub.dev/packages/pie_chart
//!!!

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireStore _fireStore = FireStore();

  Map<String, dynamic>? fetchedData;
  Iterable<Map<String, dynamic>> categories = [];
  Iterable<Map<String, dynamic>> checks = [];

  DailyVerse _dailyVerse = DailyVerse();

  Map<String, double> dataMap = {
    "To do": 0,
    "In progress": 2,
    "Done": 0,
  };

  Future<String> _fetchData() async {
    _dailyVerse = await fetchBibleVerse();

    categories = await _fireStore.readAll('Category');
    checks = await _fireStore.readAll('Check');

    dataMap['To do'] =
        checks.where((element) => element['done'] == false).length.toDouble();

    dataMap['Done'] =
        checks.where((element) => element['done'] == true).length.toDouble();

    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: false,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 30, 32, 16),
                child: AspectRatio(
                  aspectRatio: 30 / 8,
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
                            stripHtmlIfNeeded(_dailyVerse.content ?? ''),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.fontFamily,
                                fontSize: 15,
                                color: Color.fromARGB(188, 231, 143, 12),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _dailyVerse.reference ?? '',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 100 * 4,
                  width: MediaQuery.of(context).size.width / 100 * 40,
                  child: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Row(
                children: [
                  //provide all the things u want to horizontally scroll here
                  for (var item in (categories.take(categories.length ~/ 2)))
                    CategoryContainer(
                        title: item['Title'] != null ? item['Title'] : '',
                        icon: Icon(
                          IconData(
                            item['Icon'],
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 45,
                          color: Colors.black,
                        ),
                        openDoings: checks
                            .where((c) =>
                                c['category'] == item['Title'] &&
                                c['done'] == false)
                            .length),

                  const VerticalDivider(
                    width: 0,
                    color: Colors.transparent,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: [
                  //provide all the things u want to horizontally scroll here
                  for (var item in (categories.skip(categories.length ~/ 2)))
                    CategoryContainer(
                        title: item['Title'] != null ? item['Title'] : '',
                        icon: Icon(
                            IconData(item['Icon'], fontFamily: 'MaterialIcons'),
                            size: 45),
                        openDoings: checks
                            .where((c) =>
                                c['category'] == item['Title'] &&
                                c['done'] == false)
                            .length),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 14,
                    width: MediaQuery.of(context).size.width / 100 * 78,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: PieChart(
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 200),
                            colorList: [
                              Color.fromARGB(255, 0, 0, 0),
                              Color.fromARGB(255, 136, 143, 146),
                              Color.fromRGBO(238, 213, 146, 1)
                            ],
                            chartValuesOptions: ChartValuesOptions(
                                decimalPlaces: 0,
                                showChartValues: true,
                                showChartValuesInPercentage: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 35, 12, 16),
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Color.fromARGB(123, 255, 153, 0),
                          onSurface: Colors.green,
                          maximumSize: Size(300, 100),
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(188, 231, 143, 12))),

                      // style: ButtonStyle(
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.black),
                      //     backgroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.white),
                      //     maximumSize:
                      //         MaterialStateProperty.all<Size>(Size(400, 200)),
                      //     textStyle: MaterialStateProperty.all(
                      //         TextStyle(color: Colors.black))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateTaskPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text('Aanmaken taak',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
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
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2?.fontFamily,
                          fontSize: 25,
                          color: Color.fromARGB(188, 231, 143, 12),
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
        
        
// wanneer je op add drukt wat wil je toevoegen
// taak
// youtube filmpje
// wensen lijstje
  