import 'package:bloc/bloc.dart';
import 'package:reminder_app2/bloc/even.dart';
import 'package:reminder_app2/bloc/state.dart';
import 'package:reminder_app2/models/export_model.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderState([])) {
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskStatusEvent>(_onToggleTaskStatus);
  }

  void _onAddTask(AddTaskEvent event, Emitter<ReminderState> emit) {
    final updatedModels = List<ReminderModel>.from(state.reminderModels)
      ..add(event.newTask);
    emit(ReminderState(updatedModels));
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<ReminderState> emit) {
    final updatedModels =
        state.reminderModels.where((task) => task != event.task).toList();
    emit(ReminderState(updatedModels));
  }

  void _onToggleTaskStatus(
      ToggleTaskStatusEvent event, Emitter<ReminderState> emit) {
    final updatedModels = state.reminderModels.map((task) {
      if (task == event.task) {
        final isDone = !task.isDone;
        return task.copyWith(
          //
          // isDone: !task.isDone,
          // endtime: event.newEndTime ?? task.endtime,
          //
          isDone: isDone,
          doneTime: isDone ? DateTime.now() : null,
          endtime: isDone ? task.endtime : event.newEndTime,
        );
      }
      return task;
    }).toList();
    emit(ReminderState(updatedModels));
  }
}
