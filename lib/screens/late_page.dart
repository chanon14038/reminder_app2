import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app2/bloc/export_bloc.dart';
import 'package:reminder_app2/widgets/export_widgets.dart';

class LatePage extends StatelessWidget {
  const LatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Late Task')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          final lateTasks =
              state.reminderModels.where((task) => task.isLate).toList();

          return ListTask(tasks: lateTasks);
        },
      ),
    );
  }
}
