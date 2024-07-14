import 'package:flutter/material.dart';
import 'package:reminder_app2/models/export_model.dart';
import 'package:reminder_app2/widgets/datetime_picker.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

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
      appBar: AppBar(title: const Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Task'),
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
                decoration: const InputDecoration(labelText: 'Detail'),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _details = value;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'End Time'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDateTime = await showDialog<DateTime>(
                    context: context,
                    builder: (BuildContext context) {
                      return DateTimePickerDialog(
                        initialDate: _endtime ?? DateTime.now(),
                      );
                    },
                  );
                  if (pickedDateTime != null) {
                    setState(() {
                      _endtime = pickedDateTime;
                    });
                  }
                },
                controller: TextEditingController(
                  text: _endtime != null
                      ? _endtime!.toLocal().toString().split(' ')[0]
                      : '',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop(ReminderModel(
                        tasks: _task!, details: _details!, endtime: _endtime));
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
