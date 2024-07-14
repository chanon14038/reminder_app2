import 'package:flutter/material.dart';

class DateTimePickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const DateTimePickerDialog({Key? key, required this.initialDate})
      : super(key: key);

  @override
  _DateTimePickerDialogState createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<DateTimePickerDialog> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedTime = TimeOfDay.fromDateTime(widget.initialDate);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _selectedTime = pickedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Date and Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDateTime(context),
          ),
          ListTile(
            title: Text("Time: ${_selectedTime.format(context)}"),
            trailing: Icon(Icons.access_time),
            onTap: () => _selectDateTime(context),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_selectedDate);
          },
        ),
      ],
    );
  }
}