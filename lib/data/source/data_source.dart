import 'package:bloc_to_do/domain/entity/task.dart';

abstract class DataSource {
  const DataSource();

  Future<List<Task>> loadTasksPage({required int page});
  Future<void> saveTask({required Task task});
  Future<void> removeTask({required String id});
}