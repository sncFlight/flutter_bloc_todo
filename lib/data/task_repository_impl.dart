import 'package:bloc_to_do/data/source/data_source.dart';
import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final DataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});
  
  @override
  Future<void> addTask(Task task) async {
    await dataSource.saveTask(task);
  }

  @override
  Future<void> deleteTask(int id) async {
    await dataSource.removeTask(id);
  }

  @override
  Future<List<Task>> getAllTasks({required int page}) async {
    return dataSource.loadTasksPage(page: page);
  }

  @override
  Future<void> updateTask(Task task) async {
    throw UnimplementedError();
  }

}
