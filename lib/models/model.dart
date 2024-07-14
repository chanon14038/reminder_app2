import 'package:equatable/equatable.dart';

class ReminderModel extends Equatable {
  String tasks;
  String details;
  DateTime? endtime;
  bool isDone;
  DateTime? doneTime;

  ReminderModel({
    required this.tasks,
    required this.details,
    required this.endtime,
    this.isDone = false,
    this.doneTime,
  });

  bool get isLate => endtime != null && DateTime.now().isAfter(endtime!);

  @override
  List<Object?> get props => [tasks, endtime, isDone];

  ReminderModel copyWith({
    String? tasks,
    String? details,
    DateTime? endtime,
    bool? isDone,
    DateTime? doneTime,
  }) {
    return ReminderModel(
      tasks: tasks ?? this.tasks,
      details: details ?? this.details,
      endtime: endtime ?? this.endtime,
      isDone: isDone ?? this.isDone,
      doneTime: doneTime ?? this.doneTime,
    );
  }
}
