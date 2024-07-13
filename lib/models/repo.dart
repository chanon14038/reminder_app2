import 'package:reminder_app2/models/model.dart';

abstract class ReminderRepository {
  Future<List<ReminderModel>> load();
}
