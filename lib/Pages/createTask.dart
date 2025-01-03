import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/Enums/Priority.dart';
import 'package:checkit/Firebase/Firestore.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Categories? _character = Categories.Appointment;

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
      _check.category = _character.toString().split('.').last;
      _check.dateTime = DateTime.now();
      _check.done = false;
      _check.priority = Priorities.none.name;
      _check.remember = int.tryParse(_rememberController.value.text);
      _check.title = _titleController.value.text;
      _check.userid = FirebaseAuth.instance.currentUser?.uid;
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
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Material(
              child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/img/try21.png'),
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
                    color: Color.fromARGB(19, 206, 201, 194),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 0),
                          child: Text(
                            'Create new task',
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormFieldWithStyling(
                        needsExpanding: false,
                        hintText: 'Title',
                        icon: Icon(
                          Icons.wysiwyg,
                          color: Color.fromARGB(255, 190, 76, 143),
                        ),
                        controller: _titleController,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormFieldWithStyling(
                        needsExpanding: false,
                        hintText: 'Remember',
                        icon: Icon(
                          Icons.access_alarms,
                          color: Color.fromARGB(255, 190, 76, 143),
                        ),
                        controller: _rememberController,
                        textInputType: TextInputType.number,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'Appointment',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'Music',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'Private',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'Study',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'Web',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                            style: ListTileStyle.drawer,
                            title: const Text(
                              'YouTube',
                              style: TextStyle(
                                color: Color.fromARGB(187, 10, 7, 3),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            leading: Radio<Categories>(
                              activeColor: Colors.black,
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
                                backgroundColor: WidgetStateProperty.all(
                                    Color.fromARGB(255, 255, 255, 255)),
                              ),
                              onPressed: _addCheckToDB,
                              child: Text(
                                'Add',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 190, 76, 143),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    Color.fromARGB(255, 255, 255, 255)),
                              ),
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 190, 76, 143),
                                ),
                              ),
                            ),
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
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize: 25,
                          color: Color.fromARGB(255, 190, 76, 143),
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
