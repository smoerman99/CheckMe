import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:checkit/Widgets/checkCard.dart';
import 'package:flutter/material.dart';
import '../Entities/Check.dart';

class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key? key}) : super(key: key);

  @override
  State<ShowTasksPage> createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  FireStore _fireStore = FireStore();

  Iterable<Map<String, dynamic>> checks = [];

  List list = [];

  void _callRemoveTask(Check checkToRemove) async {
    // var result = await _wrapper.executeUpdate(checkToRemove);
    // setState(() {
    //   _checkList.checkList = result;
    // });
  }

  Future<String> _fetchData() async {
    checks = await _fireStore.readAll('Check');

    for (Map<String, dynamic> member in checks) {
      if (!member['done']) {
        member['dateTime'] = member['dateTime'].toDate();

        list.add(Check.fromJson(member));
      }
    }

    return 'Loaded';
  }

  void _update(int count) {
    setState(
        () => list = list.where((element) => element.done == true).toList());
  }

  filterData() {
    var filteredList =
        list.where((element) => element['category'] == 'Private').toList();
    setState(() {
      list = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              shrinkWrap: false,
              itemCount: list.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == list.length) {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateTaskPage()));
                    },
                    child: Text('Nieuwe taak aanmaken'),
                  );
                } else {
                  return CheckCard(
                      update: _update,
                      id: list[index].id,
                      title: list[index].title,
                      categorie: list[index].category,
                      dateAdded: list[index].dateTime,
                      priority: list[index].priority,
                      remember: 0 // list[index].remember ,
                      );
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          );
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
