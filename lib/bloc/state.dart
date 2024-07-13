import 'package:equatable/equatable.dart';
import 'package:reminder_app2/models/model.dart';

class ReminderState extends Equatable {
  final List<ReminderModel> reminderModels;

  const ReminderState(this.reminderModels);

  @override
  List<Object> get props => [reminderModels];
}
