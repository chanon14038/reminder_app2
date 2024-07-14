import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/widgets/datetime_picker.dart';
import 'package:intl/intl.dart';

class DonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Done Tasks')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          final doneTasks =
              state.reminderModels.where((task) => task.isDone).toList();

          return ListView.builder(
            itemCount: doneTasks.length,
            itemBuilder: (context, index) {
              final task = doneTasks[index];
              final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
              final DateFormat timeFormat = DateFormat('HH:mm:ss');

              return ListTile(
                title: Text(task.tasks),
                subtitle: Text(
                  'Details: ${task.details}\nEnd Time: ${task.endtime != null ? "${dateFormat.format(task.endtime!)} ${timeFormat.format(task.endtime!)}" : 'No deadline'}\nDone Time: ${task.doneTime != null ? timeFormat.format(task.doneTime!) : 'Not done yet'}',
                ),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) async {
                    if (value == false) {
                      final DateTime? newEndTime = await showDialog<DateTime>(
                        context: context,
                        builder: (BuildContext context) {
                          return DateTimePickerDialog(
                            initialDate: DateTime.now(),
                          );
                        },
                      );
                      if (newEndTime != null) {
                        context.read<ReminderBloc>().add(
                              ToggleTaskStatusEvent(task,
                                  newEndTime: newEndTime),
                            );
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
