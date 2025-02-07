import 'package:equatable/equatable.dart';
import 'package:reminder_app2/models/export_model.dart';

sealed class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends ReminderEvent {
  final ReminderModel newTask;

  const AddTaskEvent(this.newTask);

  @override
  List<Object?> get props => [newTask];
}

class DeleteTaskEvent extends ReminderEvent {
  final ReminderModel task;

  const DeleteTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class ToggleTaskStatusEvent extends ReminderEvent {
  final ReminderModel task;
  final DateTime? newEndTime;

  const ToggleTaskStatusEvent(this.task, {this.newEndTime});

  @override
  List<Object?> get props => [task, newEndTime];
}

class EditTaskEvent extends ReminderEvent {
  final ReminderModel oldTask;
  final ReminderModel newTask;

  const EditTaskEvent(this.oldTask, this.newTask);

  @override
  List<Object?> get props => [oldTask, newTask];
}
