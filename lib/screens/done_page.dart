import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';

class DonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Done Task')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          // Filter tasks that are not done
          final notDoneTasks =
              state.reminderModels.where((task) => task.isDone).toList();

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
                    context.read<ReminderBloc>().add(CompleteTaskEvent(task));
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
