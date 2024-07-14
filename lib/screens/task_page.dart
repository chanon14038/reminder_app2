import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/screens/add_tasks.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Tasks')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          // Filter tasks that are not done and not late
          final notDoneTasks = state.reminderModels
              .where((task) => !task.isDone && !task.isLate)
              .toList();

          return ListView.builder(
            itemCount: notDoneTasks.length,
            itemBuilder: (context, index) {
              final task = notDoneTasks[index];
              return ListTile(
                title: Text(task.tasks),
                subtitle: Text(
                    '\t${task.details}\n${task.endtime?.toString() ?? 'No deadline'}'),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    context
                        .read<ReminderBloc>()
                        .add(ToggleTaskStatusEvent(task));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
          if (newTask != null) {
            context.read<ReminderBloc>().add(AddTaskEvent(newTask));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
