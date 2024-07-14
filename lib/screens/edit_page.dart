import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app2/models/export_model.dart';

class EditTaskPage extends StatefulWidget {
  final ReminderModel task;

  const EditTaskPage({super.key, required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _taskController;
  late TextEditingController _detailsController;
  DateTime? _endtime;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task.tasks);
    _detailsController = TextEditingController(text: widget.task.details);
    _endtime = widget.task.endtime;
  }

  @override
  void dispose() {
    _taskController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endtime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_endtime ?? DateTime.now()),
      );
      if (pickedTime != null) {
        setState(() {
          _endtime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _detailsController,
              decoration: const InputDecoration(
                labelText: 'Details',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectEndTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text: _endtime != null
                        ? DateFormat('yyyy-MM-dd HH:mm').format(_endtime!)
                        : '',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedTask = widget.task.copyWith(
                  tasks: _taskController.text,
                  details: _detailsController.text,
                  endtime: _endtime,
                );
                Navigator.of(context).pop(updatedTask);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
