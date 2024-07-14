import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/widgets/list_task.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Done Tasks')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          final doneTasks =
              state.reminderModels.where((task) => task.isDone).toList();

          return ListTask(tasks: doneTasks);
        },
      ),
    );
  }
}
