import 'package:bloc_to_do/domain/entity/task.dart';

abstract class TasksRepository {
  Future<List<Task>> getAllTasks({required int page});
  Future<void> addTask({required Task task});
  Future<void> removeTask({required String id});
}
