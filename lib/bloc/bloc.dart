import 'package:bloc/bloc.dart';
import 'package:reminder_app2/bloc/even.dart';
import 'package:reminder_app2/bloc/state.dart';
import 'package:reminder_app2/models/export_model.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(ReminderState([])) {
    on<AddTaskEvent>(_onAddTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ReleaseTaskEvent>(_onReleaseTask);
  }

  void _onAddTask(AddTaskEvent event, Emitter<ReminderState> emit) {
    final updatedModels = List<ReminderModel>.from(state.reminderModels)
      ..add(event.newTask);
    emit(ReminderState(updatedModels));
  }

  void _onCompleteTask(event, emit) {
    final updatedModels = state.reminderModels.map((task) {
      return task == event.task ? task.copyWith(isDone: true) : task;
    }).toList();
    emit(ReminderState(updatedModels));
  }

  void _onDeleteTask(event, emit) {
    final updatedModels =
        state.reminderModels.where((task) => task != event.task).toList();
    emit(ReminderState(updatedModels));
  }

  void _onReleaseTask(even,  emit){}
}
