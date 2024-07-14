import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const DateTimePickerDialog({super.key, required this.initialDate});

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Date and Time'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                _selectedDate != null
                    ? 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                    : 'Select Date',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text(
                _selectedTime != null
                    ? 'Time: ${_selectedTime!.format(context)}'
                    : 'Select Time',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
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
