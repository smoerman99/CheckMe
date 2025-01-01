import 'package:checkit/Assets/NavigationWrapper.dart';
import 'package:checkit/Assets/StringThings.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Pages/createTask.dart';
import 'package:checkit/Widgets/checkCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Entities/Check.dart';

class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key? key}) : super(key: key);

  @override
  State<ShowTasksPage> createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  FireStore _fireStore = FireStore();

  List filteredData = [];
  List orginalData = [];

  Future<String> _fetchData() async {
    if (orginalData.length == 0) {
      for (Map<String, dynamic> member in await _fireStore.readAll('Check')) {
        if (!member['done'] &&
            member['userid'] == FirebaseAuth.instance.currentUser?.uid) {
          member['dateTime'] = member['dateTime'].toDate();

          filteredData.add(Check.fromJson(member));
          orginalData.add(Check.fromJson(member));
        }
      }
    }

    return 'Loaded';
  }

  void _update(int count) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationWrapper(
          openTaskPage: true,
        ),
      ),
    );
  }

  filterData(String category) {
    filteredData = orginalData;

    var test =
        filteredData.where((element) => element.category == category).toList();

    setState(() {
      filteredData = test;
    });
  }

  void resetFilter() {
    setState(() {
      filteredData = orginalData;
      // Refetch or reset to the original unfiltered list.
    });

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: FutureBuilder(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100 * 22,
                ),
                // Horizontal ListView (Buttons for filtering)
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('Music'),
                          child: Text(
                            'Music',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('YouTube'),
                          child: Text(
                            'YouTube',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('Web'),
                          child: Text(
                            'Web',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('Private'),
                          child: Text(
                            'Private',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('Appointment'),
                          child: Text(
                            'Appointment',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => filterData('Study'),
                          child: Text(
                            'Study',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => resetFilter(),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // Flexible Widget for the Vertical ListView
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.only(),
                    itemCount: filteredData.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == filteredData.length) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(100, 15, 100, 0),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.black),
                                fixedSize: WidgetStateProperty.all<Size>(
                                    Size.fromWidth(250))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateTaskPage()),
                              ).then((_) {
                                // Replace the current page with a new instance
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationWrapper(
                                      openTaskPage: true,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Create task',
                              style: TextStyle(
                                color: Color.fromARGB(255, 190, 76, 143),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // List items for filteredData
                        return Column(
                          children: [
                            CheckCard(
                              update: _update,
                              id: filteredData[index].id,
                              title: filteredData[index]
                                  .title
                                  .toString()
                                  .makeFirstLetterCapitalize(),
                              categorie: filteredData[index].category,
                              dateAdded: filteredData[index].dateTime,
                              priority: filteredData[index].priority,
                              remember: 0, // list[index].remember ,
                            ),
                            const Divider(
                              indent: 0,
                              height: 5,
                              thickness: 0,
                              color: Colors.amber,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              shrinkWrap: true,
              children: [
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
