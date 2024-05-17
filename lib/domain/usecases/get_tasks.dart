import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class GetTasks {
  final TasksRepository repository;

  const GetTasks({
    required this.repository,
  });

  Future<List<Task>> call({int page = 0}) async {
    final List<Task> tasks = await repository.getAllTasks(page: page);

    return tasks;
  }
}