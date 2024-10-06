import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/Enums/Priority.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Widgets/HandleElevatedButton.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';

import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

enum Categories { Music, YouTube, Web, Private, Appointment, Study }

class _CreateTaskPageState extends State<CreateTaskPage> {
  FireStore _fireStore = FireStore();

  final _check = Check();

  final _titleController = TextEditingController();
  final _rememberController = TextEditingController();

  Iterable<Map<String, dynamic>> categories = [];
  String? defaultSelectedCategory = 'Music';
  List<DropdownMenuItem<String>>? allCategories;

  Future<String> _fetchData() async {
    categories = await _fireStore.readAll('Category');

    mapCategoryItems();

    return 'Loaded';
  }

  void mapCategoryItems() {
    setState(() {
      allCategories = [];
    });

    for (var item in (categories)) {
      allCategories?.add(
        new DropdownMenuItem<String>(
          child: Text(
            item['Title'],
          ),
          value: item['Title'],
        ),
      );
    }
  }

  Future<void> _addCheckToDB() async {
    setState(() {
      _check.category = defaultSelectedCategory;
      _check.dateTime = DateTime.now();
      _check.done = false;
      _check.priority = Priorities.none.name;
      _check.remember = int.tryParse(_rememberController.value.text);
      _check.title = _titleController.value.text;
    });

    await _fireStore.create('Check', _check.toFirestore());

    clearTextField();
    popOrNot(true);
  }

  void clearTextField() {
    _titleController.clear();
    _rememberController.clear();
  }

  void popOrNot(bool popPage) {
    if (popPage) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Categories? _character = Categories.Appointment;

    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Material(
              child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/img/try19.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(children: [
              SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color.fromRGBO(243, 243, 243, 0.158),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Create Task',
                          style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.fontFamily,
                              fontStyle: FontStyle.italic,
                              fontSize: 36,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormFieldWithStyling(
                          needsExpanding: false,
                          hintText: 'Title',
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          taskNameController: _titleController,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormFieldWithStyling(
                        needsExpanding: false,
                        hintText: 'Remember',
                        icon: Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                        taskNameController: _rememberController,
                        textInputType: TextInputType.number,
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: const Text('Appointment'),
                            leading: Radio<Categories>(
                              value: Categories.Appointment,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Music'),
                            leading: Radio<Categories>(
                              value: Categories.Music,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Private'),
                            leading: Radio<Categories>(
                              value: Categories.Private,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Study'),
                            leading: Radio<Categories>(
                              value: Categories.Study,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Web'),
                            leading: Radio<Categories>(
                              value: Categories.Web,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('YouTube'),
                            leading: Radio<Categories>(
                              value: Categories.YouTube,
                              groupValue: _character,
                              onChanged: (Categories? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 119, 110, 96)),
                              ),
                              onPressed: _addCheckToDB,
                              child: Text(
                                'Add',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 17,
                                  backgroundColor:
                                      Color.fromARGB(255, 119, 110, 96),
                                ),
                              ),
                            ),

                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 119, 110, 96)),
                              ),
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  fontSize: 17,
                                  backgroundColor:
                                      Color.fromARGB(255, 119, 110, 96),
                                ),
                              ),
                            ),
                            // HandleElevatedButton(
                            //   title: "Add",
                            //   textController: _titleController,
                            //   closePage: false,
                            // ),
                            // SizedBox(
                            //   width: 18,
                            // ),
                            // HandleElevatedButton(
                            //   title: "Add & Close",
                            //   textController: _titleController,
                            //   closePage: true,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ));
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
                          color: Color.fromRGBO(112, 29, 29, 1),
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
