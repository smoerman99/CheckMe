import 'package:checkit/Entities/Check.dart';
import 'package:checkit/Entities/Enums/Priority.dart';
import 'package:checkit/Widgets/HandleElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../Widgets/textFormFieldWithStyling.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context, false)),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Create new Task",
          style: TextStyle(
              color: Theme.of(context).navigationBarTheme.backgroundColor),
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: [
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
    );
  }
}
