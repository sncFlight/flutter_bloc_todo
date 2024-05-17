import 'package:bloc_to_do/data/source/data_source.dart';
import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final DataSource dataSource;

  TasksRepositoryImpl({required this.dataSource});
  
  @override
  Future<void> addTask({required Task task}) async {
    await dataSource.saveTask(task: task);
  }

  @override
  Future<List<Task>> getAllTasks({required int page}) async {
    return dataSource.loadTasksPage(page: page);
  }

  @override
  Future<void> removeTask({required String id}) async {
    return dataSource.removeTask(id: id);
  }
}
