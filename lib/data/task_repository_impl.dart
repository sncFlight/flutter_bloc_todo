import 'package:bloc_to_do/data/source/data_source.dart';
import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class TaskRepositoryImpl extends TasksRepository {
  final DataSource dataSource;

  TaskRepositoryImpl({required this.dataSource});
  
  @override
  Future<void> addTask({required Task task}) async {
    await dataSource.saveTask(task);
  }

  @override
  Future<void> removeTask({required int id}) async {
    await dataSource.removeTask(id);
  }

  @override
  Future<List<Task>> getAllTasks({required int page}) async {
    return dataSource.loadTasksPage(page: page);
  }

  @override
  Future<void> updateTask({required Task task}) async {
    throw UnimplementedError();
  }

}
