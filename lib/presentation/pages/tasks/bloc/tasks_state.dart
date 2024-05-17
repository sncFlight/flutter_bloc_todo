import 'package:equatable/equatable.dart';

import 'package:bloc_to_do/domain/entity/task.dart';

enum TasksStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

class TasksState extends Equatable {
  final TasksStatus status;
  final List<Task> tasks;
  final bool hasReachedEnd;
  final int currentPage;
  final String snackBarMessage;
  
  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const [],
    this.hasReachedEnd = false,
    this.snackBarMessage = '',
    this.currentPage = 0,
  });

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    bool? hasReachedEnd,
    int? currentPage,
    String? snackBarMessage,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      snackBarMessage: snackBarMessage ?? '',
    );
  }

  @override
  List<Object> get props => [
    status,
    tasks,
    hasReachedEnd,
    currentPage,
    snackBarMessage,
  ];
}