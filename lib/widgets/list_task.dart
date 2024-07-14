import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/models/export_model.dart';
import 'package:reminder_app2/screens/edit_page.dart';

class ListTask extends StatelessWidget {
  final List<ReminderModel> tasks;

  const ListTask({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final DateFormat timeFormat = DateFormat('HH:mm:ss');
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        return ListTile(
          title: Text(task.tasks),
          subtitle: Text(
              'Details: ${task.details}\nEnd Time: ${task.endtime != null ? "${dateFormat.format(task.endtime!)} ${timeFormat.format(task.endtime!)}" : 'No deadline'} \n${task.isDone ? "Done Time: ${dateFormat.format(task.doneTime!)} ${timeFormat.format(task.doneTime!)}" : ''}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final editedTask = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: task),
                    ),
                  );
                  if (editedTask != null) {
                    context
                        .read<ReminderBloc>()
                        .add(EditTaskEvent(task, editedTask));
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<ReminderBloc>().add(DeleteTaskEvent(task));
                },
              ),
              Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<ReminderBloc>().add(ToggleTaskStatusEvent(task));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
