import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class GetAllTasks {
  final TasksRepository repository;

  const GetAllTasks({
    required this.repository,
  });

  Future<List<Task>> call({int page = 0}) async {
    final List<Task> tasks = await repository.getAllTasks(page: page);

    return tasks;
  }
}