// import 'package:checkit/Entities/CheckList.dart';
// import 'package:checkit/JsonThings/Wrapper_Firebase.dart';
// import 'package:flutter/material.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key key}) : super(key: key);

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   TextEditingController _usernameEditingController = TextEditingController();

//   Wrapper wrapper = Wrapper();

//   MotherObject _user;

//   @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

//   Future fetchData() async {
//     var result = await wrapper.readUserWithData();

//     setState(() {
//       _user = result;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           _user != null && _user.name.length > 0
//               ? Text(_user.name)
//               : Text("loading"),
//         ],
//       ),
//     );
//   }
// }



// // hier kunnen projecten worden toegevoegd waar taken aan gekoppeld kunnen worden.
// // darkmode
// // over hoeveel dagen herinneringen sturen regelen