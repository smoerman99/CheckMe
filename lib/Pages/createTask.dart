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
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Material(
              child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('assets/img/try14.png'),
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
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Create Task',
                          style: TextStyle(
                            fontSize: 36,
                            color: Color.fromRGBO(150, 90, 90, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormFieldWithStyling(
                          needsExpanding: false,
                          hintText: 'Title',
                          icon: Icon(Icons.menu),
                          taskNameController: _titleController,
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormFieldWithStyling(
                          needsExpanding: false,
                          hintText: 'Remember',
                          icon: Icon(Icons.numbers),
                          taskNameController: _rememberController,
                          textInputType: TextInputType.number),
                      DropdownButton<String>(
                        value: defaultSelectedCategory,
                        icon: const Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(150, 90, 90, 1)),
                        elevation: 16,
                        style: const TextStyle(
                          color: Color.fromRGBO(150, 90, 90, 1),
                          fontSize: 18,
                        ),
                        underline: Container(
                          height: 2,
                          color: Color.fromRGBO(150, 90, 90, 1),
                        ),
                        onChanged: (value) {
                          // This is called when the user selects an item.
                          setState(() {
                            defaultSelectedCategory = value;
                          });
                        },
                        items: allCategories,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _addCheckToDB,
                            child: Text('Add'),
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
