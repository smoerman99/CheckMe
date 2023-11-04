import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/Enums/Priority.dart';
import 'package:checkit/Widgets/HandleElevatedButton.dart';
import 'package:checkit/Widgets/TextFormFieldWithStyling.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _check = Check();
  final _titleController = TextEditingController();
  final _projectController = TextEditingController();
  final _priority = Priorities;
  int remember = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/img/try16.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'het mergen van de formuliervelden naar 1 mooie text input'),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      // icon: Icon(Icons.task),
                      hintText: 'What are you up to?',
                      labelText: 'Task',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      setState(() {
                        _check.title = value;
                      });
                    },
                    validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextFormFieldWithStyling(
                      needsExpanding: false,
                      hintText: 'Project',
                      icon: Icon(Icons.access_alarm),
                      taskNameController: TextEditingController(),
                      textInputType: TextInputType.number),
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
      ),
    );
  }
}
