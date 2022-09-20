import 'package:checkit/Entities/MotherObject.dart';
import 'package:checkit/JsonThings/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Wrapper _wrapper = Wrapper();

  MotherObject _user = MotherObject();

  Map<String, double> dataMap = {
    "To do": 5,
    "In progress": 3,
    "Done": 2,
  };

  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var result = await _wrapper.readUserWithData();
    setState(() {
      _user = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                      image: AssetImage('assets/img/mewithoutbackground.png'),
                      height: 125),
                  Container(
                    child: Text(
                      "Hi " + _user.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: "RobotoMono"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Card(
            child: ListTile(
              title: Column(
                children: [
                  Text(
                    _user.mood,
                    style: TextStyle(fontSize: 18, fontFamily: "RobotoMono"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  ),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 200),
                    colorList: [Colors.red, Colors.grey, Colors.blue],
                    chartValuesOptions: ChartValuesOptions(
                        decimalPlaces: 1, showChartValuesInPercentage: true),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
