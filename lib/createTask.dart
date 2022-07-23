import 'package:checkit/JsonThings/wrapper.dart';
import 'package:flutter/material.dart';
import 'Entities/Check.dart';
import 'Widgets/TextFormFieldWithStyling.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _wrapper = new Wrapper();

  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();

  String _errorMessage = "";

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
              color: Theme.of(context).appBarTheme.textTheme.bodyText1.color),
        ),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: [
            Container(
              height: 200,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormFieldWithStyling(
                        taskNameController: _taskNameController),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).buttonColor)),
                        onPressed: () => {
                              if (_taskNameController.text != "" ||
                                  _taskNameController.text.isNotEmpty)
                                {
                                  print(_taskNameController.text),
                                  _wrapper.executeWrite(new Check(
                                      _taskNameController.text, false)),
                                  _taskNameController.text == ""
                                }
                              else
                                {
                                  setState(() {
                                    _errorMessage = "Please insert something";
                                  })
                                }
                            },
                        child: Text(
                          "Create",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
