import 'package:reminder_app2/models/model.dart';

sealed class ReminderEvent {}

class AddTaskEvent extends ReminderEvent {
  final ReminderModel newTask;

  AddTaskEvent(this.newTask);

}

class CompleteTaskEvent extends ReminderEvent {
  final ReminderModel task;

  CompleteTaskEvent(this.task);
}

class DeleteTaskEvent extends ReminderEvent {
  final ReminderModel task;

  DeleteTaskEvent(this.task);
}


class ReleaseTaskEvent extends ReminderEvent {
  final ReleaseTaskEvent task;

  ReleaseTaskEvent(this.task);
  List<Object> get props => [task];
}