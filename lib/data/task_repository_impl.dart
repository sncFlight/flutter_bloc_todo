import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final 
  
  @override
  Future<void> addTask(Task task) {
  }

  @override
  Future<void> deleteTask(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTasks() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    throw UnimplementedError();
  }

}
