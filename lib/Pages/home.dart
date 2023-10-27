import 'package:checkit/Entities/CheckList.dart';
import 'package:checkit/Pages/CreateTask.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:checkit/Widgets/TextWidget.dart';
import 'package:flutter/material.dart';

//https://pub.dev/packages/pie_chart
//!!!

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CheckList _user;

  Map<String, double> dataMap = {
    "To do": 5,
    "In progress": 3,
    "Done": 2,
  };

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future fetchData() async {
    // var result = await widget._wrapper.readUserWithData();

    // Future.delayed(new Duration(milliseconds: 750), () {
    //   setState(() {
    //     _user = result;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 35, 32, 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromRGBO(16, 86, 120, 1),
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Loof den HEERE, mijn ziel, en vergeet geen van Zijn weldaden. Die al uw ongerechtigheid vergeeft, die al uw krankheden geneest.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Text('Psalm 103: 2-3')
                  ],
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Priority'), Text('5 tasks')]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Boeken kopen",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Firebase create task",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "hier komt dan een hele mooie omschrijving die na x tekens weggaat",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                width: 415,
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
      ),
    );
  }
}


// statistieken tonen van hoeveel taken nog te doen
// hoeveel afgerond/
// loop je op schema

// wanneer je op add drukt wat wil je toevoegen
// taak
// youtube filmpje
// wensen lijstje