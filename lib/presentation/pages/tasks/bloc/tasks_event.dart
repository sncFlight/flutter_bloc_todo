import 'package:equatable/equatable.dart';

import 'package:bloc_to_do/domain/entity/task.dart';

// Base class for all events related to tasks
class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

// Event to load the first page of tasks
class LoadFirstPageEvent extends TasksEvent {
  const LoadFirstPageEvent();
}

// Event to fetch the next page of tasks
class FetchNextPageEvent extends TasksEvent {
  const FetchNextPageEvent();
}

// Event triggered when a task is clicked
class TaskClickedEvent extends TasksEvent {
  final Task task;

  const TaskClickedEvent({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

// Event to add a new task
class AddNewTaskEvent extends TasksEvent {
  final String title;
  final String description;

  const AddNewTaskEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

// Event to remove a task
class RemoveTaskEvent extends TasksEvent {
  const RemoveTaskEvent();
}

// Event to update a task
class UpdateTaskEvent extends TasksEvent {
  const UpdateTaskEvent();
}
