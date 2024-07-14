import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/screens/add_tasks.dart';
import 'package:reminder_app2/widgets/export_widgets.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Tasks')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          final notDoneTasks = state.reminderModels
              .where((task) => !task.isDone && !task.isLate)
              .toList();

          return ListTask(tasks: notDoneTasks);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTaskPage(),
            ),
          );
          if (newTask != null) {
            context.read<ReminderBloc>().add(AddTaskEvent(newTask));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
