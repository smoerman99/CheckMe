// import 'package:checkit/Entities/CheckList.dart';
// import 'package:checkit/JsonThings/Wrapper_Firebase.dart';

// import 'package:checkit/Widgets/TextWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';

// //https://pub.dev/packages/pie_chart
// //!!!

// class HomePage extends StatefulWidget {
//   const HomePage({Key key, @required Wrapper wrapper})
//       : _wrapper = wrapper,
//         super(key: key);

//   final Wrapper _wrapper;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   CheckList _user;

//   Map<String, double> dataMap = {
//     "To do": 5,
//     "In progress": 3,
//     "Done": 2,
//   };

//   @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

//   Future fetchData() async {
//     var result = await widget._wrapper.readUserWithData();

//     Future.delayed(new Duration(milliseconds: 750), () {
//       setState(() {
//         _user = result;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
//           child: Card(
//             child: ListTile(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Image(
//                       image: AssetImage('assets/img/mewithoutbackground.png'),
//                       height: 125),
//                   Container(
//                     child: _user != null && _user.name.length > 0
//                         ? TextWidget(
//                             content: "Hi " + _user.name,
//                             fontSize: 22,
//                           )
//                         : TextWidget(
//                             content: "Hang on\na moment", fontSize: 22),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
//           child: Card(
//             child: ListTile(
//               title: Column(
//                 children: [
//                   _user != null && _user.mood.length > 0
//                       ? TextWidget(content: _user.mood, fontSize: 18)
//                       : TextWidget(content: "Loading...", fontSize: 18),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                   ),
//                   PieChart(
//                     dataMap: dataMap,
//                     animationDuration: Duration(milliseconds: 200),
//                     colorList: [Colors.red, Colors.grey, Colors.blue],
//                     chartValuesOptions: ChartValuesOptions(
//                         decimalPlaces: 1, showChartValuesInPercentage: true),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }


// // statistieken tonen van hoeveel taken nog te doen
// // hoeveel afgerond/
// // loop je op schema

// // wanneer je op add drukt wat wil je toevoegen
// // taak
// // youtube filmpje
// // wensen lijstje