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
        final DateFormat timeFormat = DateFormat('HH:mm');
        final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.tasks,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Details: ${task.details}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'End Time: ${task.endtime != null ? "${dateFormat.format(task.endtime!)} ${timeFormat.format(task.endtime!)}" : 'No deadline'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (task.isDone && task.doneTime != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Done Time: ${dateFormat.format(task.doneTime!)} ${timeFormat.format(task.doneTime!)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<ReminderBloc>()
                              .add(DeleteTaskEvent(task));
                        },
                      ),
                      Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          context
                              .read<ReminderBloc>()
                              .add(ToggleTaskStatusEvent(task));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
