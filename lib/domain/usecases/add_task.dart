import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/repository/tasks_repository.dart';

class AddTask {
  final TasksRepository repository;

  const AddTask({
    required this.repository,
  });

  Future<void> call({required Task task}) async {
    await repository.addTask(task: task);
  }
}