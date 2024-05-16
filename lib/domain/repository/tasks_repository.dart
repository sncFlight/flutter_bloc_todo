import 'package:bloc_to_do/domain/entity/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks({required int page});
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}
