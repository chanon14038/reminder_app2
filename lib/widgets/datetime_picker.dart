import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const DateTimePickerDialog({Key? key, required this.initialDate})
      : super(key: key);

  @override
  _DateTimePickerDialogState createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<DateTimePickerDialog> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedTime = TimeOfDay.fromDateTime(widget.initialDate);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
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
    } //else {
    // setState(() {
    //   _selectedTime = null;
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Date and Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
                'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}\nTime: ${DateFormat('HH:mm:ss').format(_selectedDate!)}'),
            trailing: Icon(Icons.calendar_today),
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
            if (_selectedDate != null && _selectedTime != null) {
              final DateTime finalDateTime = DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedTime!.hour,
                _selectedTime!.minute,
              );
              Navigator.of(context).pop(finalDateTime);
            } else {
              // Handle the case where date or time is not selected
              // Show a message or keep the dialog open
            }
          },
        ),
      ],
    );
  }
}
