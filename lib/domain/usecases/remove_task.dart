import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class RemoveTask {
  final TasksRepository repository;

  const RemoveTask({
    required this.repository,
  });

  Future<void> call({required Task task}) async {
    await repository.removeTask(id: task.id);
  }
}