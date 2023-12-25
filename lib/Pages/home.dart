import 'package:checkit/Entities/CheckList.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import '../Widgets/categoryContainer.dart';

//https://pub.dev/packages/pie_chart
//!!!

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireStore _fireStore = FireStore();

  Map<String, dynamic> fetchedData;
  Iterable<Map<String, dynamic>> categories;

  Map<String, double> dataMap = {
    "To do": 5,
    "In progress": 3,
    "Done": 2,
  };

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    //need to add icon to the firebase object and map this to the frontend.
    categories = await _fireStore.readAll('Category');

    //or with and foreach
    // fetchedData.forEach((key, value) {
    //   categories.add(value);
    // });
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(milliseconds: 300),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _calculation,
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
                              'Loof den HEERE, mijn ziel, en vergeet geen van Zijn weldaden. Die al uw ongerechtigheid vergeeft, die al uw krankheden geneest.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .fontFamily,
                                fontSize: 15,
                                color: Color.fromRGBO(112, 29, 29, 1),
                              ),
                            ),
                            Text(
                              'Psalm 103: 2-3',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                        openDoings: 2,
                        title: item['Title'] != null ? item['Title'] : '',
                        icon: Icon(Icons.abc),
                      )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Row(
                  children: [
                    //provide all the things u want to horizontally scroll here
                    for (var item in (categories.skip(categories.length ~/ 2)))
                      CategoryContainer(
                        openDoings: 2,
                        title: item['Title'] != null ? item['Title'] : '',
                        icon: Icon(Icons.abc),
                      )
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
                      height: MediaQuery.of(context).size.height / 100 * 20,
                      width: MediaQuery.of(context).size.width / 100 * 95,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: PieChart(
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 200),
                              colorList: [
                                Colors.black,
                                Colors.blueGrey,
                                Colors.lightBlueAccent
                              ],
                              chartValuesOptions: ChartValuesOptions(
                                  decimalPlaces: 1,
                                  showChartValuesInPercentage: true),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  child: Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateTaskPage()));
                            },
                            child: Text('Nieuwe taak aanmaken'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
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
                              Theme.of(context).textTheme.bodyText2.fontFamily,
                          fontSize: 25,
                          color: Color.fromRGBO(112, 29, 29, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);
        });
  }
}

// statistieken tonen van hoeveel taken nog te doen
// hoeveel afgerond/
// loop je op schema

// wanneer je op add drukt wat wil je toevoegen
// taak
// youtube filmpje
// wensen lijstje
