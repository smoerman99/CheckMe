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

  final _formKey = GlobalKey<FormState>();

  final _check = Check();
  final _titleController = TextEditingController();
  final _projectController = TextEditingController();
  final _priority = Priorities;
  final int remember = 0;

  Iterable<Map<String, dynamic>> categories = [];
  String? dropdownValue = 'Music';
  List<DropdownMenuItem<String>>? list2;

  Future<String> _fetchData() async {
    categories = await _fireStore.readAll('Category');

    mapCategoryItems();

    return 'Loaded';
  }

  void mapCategoryItems() {
    setState(() {
      list2 = [];
    });

    for (var item in (categories)) {
      list2?.add(
        new DropdownMenuItem<String>(
          child: Text(
            item['Title'],
          ),
          value: item['Title'],
        ),
      );
    }

    print(list2?.first.value);
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
                image: new ExactAssetImage('assets/img/try19.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Container(
                  height: 300,
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
                        child: Text('Create Task',
                            style: TextStyle(
                                fontSize: 32,
                                color: Color.fromRGBO(150, 90, 90, 1))),
                      ),
                      TextFormFieldWithStyling(
                          needsExpanding: false,
                          hintText: 'Title',
                          icon: Icon(Icons.title),
                          taskNameController: TextEditingController(),
                          textInputType: TextInputType.text),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        items: list2,
                      ),
                      HandleElevatedButton(
                        title: "Add",
                        textController: _titleController,
                        closePage: false,
                      ),
                      HandleElevatedButton(
                        title: "Add & Close",
                        textController: _titleController,
                        closePage: true,
                      )
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
