import 'package:flutter/material.dart';
import 'package:reminder_app2/models/export_model.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String? _task;
  String? _details;
  DateTime? _endtime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Task'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task';
                  }
                  return null;
                },
                onSaved: (value) {
                  _task = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detail'),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _details = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'End Time'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _endtime = picked;
                    });
                  }
                },
                controller: TextEditingController(
                  text: _endtime != null
                      ? _endtime!.toLocal().toString().split(' ')[0]
                      : '',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop(ReminderModel(
                        tasks: _task!, details: _details!, endtime: _endtime));
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
