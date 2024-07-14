import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/widgets/datetime_picker.dart';

class LatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Late Task')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          // Filter tasks that are not done
          final lateTask =
              state.reminderModels.where((task) => task.isLate).toList();

          final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
          final DateFormat timeFormat = DateFormat('HH:mm:ss');

          return ListView.builder(
            itemCount: lateTask.length,
            itemBuilder: (context, index) {
              final task = lateTask[index];
              return ListTile(
                title: Text(task.tasks),
                subtitle: Text(
                    'Details: ${task.details}\nEnd Time: ${task.endtime != null ? "${dateFormat.format(task.endtime!)} ${timeFormat.format(task.endtime!)}" : 'No deadline'}'),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) async {
                    if (value == false) {
                      // Show dialog to pick a new end date and time
                      final DateTime? newEndTime = await showDialog<DateTime>(
                        context: context,
                        builder: (BuildContext context) {
                          return DateTimePickerDialog(
                            initialDate: task.endtime ?? DateTime.now(),
                          );
                        },
                      );
                      if (newEndTime != null) {
                        context.read<ReminderBloc>().add(ToggleTaskStatusEvent(
                            task,
                            newEndTime: newEndTime));
                      }
                    } else {
                      context
                          .read<ReminderBloc>()
                          .add(ToggleTaskStatusEvent(task));
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
