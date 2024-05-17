import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:bloc_to_do/domain/usecases/add_task.dart';
import 'package:bloc_to_do/domain/usecases/get_tasks.dart';
import 'package:bloc_to_do/domain/usecases/remove_task.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_event.dart';
import 'package:bloc_to_do/presentation/pages/tasks/bloc/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final RemoveTask removeTask;

  TasksBloc({
    required this.getTasks,
    required this.addTask,
    required this.removeTask,
  }) : super(const TasksState()) {
    on<AddNewTaskEvent>(_addNewTask);
    on<TaskClickedEvent>(_taskClicked);
    on<LoadFirstPageEvent>(_loadFirstPage);
    on<FetchNextPageEvent>(_fetchNextPage);
  }

  // Method to handle adding a new task
  Future<void> _addNewTask(AddNewTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TasksStatus.loading));

    // Create a new task with a unique ID
    final Task task = Task(
      id: const Uuid().v4(),
      title: event.title,
      description: event.description,
    );

    // Add the new task to the repository
    await addTask(task: task);

    // Update the state with the new task and a success message
    emit(
      state.copyWith(
        status: TasksStatus.success,
        tasks: List.of(state.tasks)..addAll([task]),
        snackBarMessage: 'New task added',
      ),
    );
  }

  // Method to handle clicking on a task
  Future<void> _taskClicked(TaskClickedEvent event, Emitter<TasksState> emit) async {
    final int index = state.tasks.indexWhere((Task task) => task.id == event.task.id);

    if (index != -1) {
        final Task updatedTask = Task(
          id: event.task.id,
          description: event.task.description,
          title: event.task.title,
          isCompleted: true,
        );

        final List<Task> updatedTasks = List<Task>.from(state.tasks);
        updatedTasks[index] = updatedTask;

        emit(state.copyWith(
          status: TasksStatus.success,
          tasks: updatedTasks,
        ));

        // Remove task after delay
        await Future.delayed(const Duration(milliseconds: 1500));

        // Check if the task still exists in the list (it might have been modified during the delay)
        final currentIndex = state.tasks.indexWhere((Task task) => task.id == event.task.id);
        if (currentIndex != -1) {
          final List<Task> tasksAfterRemoval = List<Task>.from(state.tasks)..removeAt(currentIndex);

          emit(state.copyWith(
            status: TasksStatus.success,
            tasks: tasksAfterRemoval,
            snackBarMessage: 'Congratulations! You completed the task',
          ));
        }

        // Remove task from repository
        await removeTask(task: event.task);
    }
  }

  // Method to load the first page of tasks
  Future<void> _loadFirstPage(LoadFirstPageEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TasksStatus.loading));
  
    final List<Task> tasks = await getTasks(page: 0);
    
    emit(
      state.copyWith(
        status: TasksStatus.success,
        tasks: tasks,
        hasReachedEnd: tasks.isEmpty,
        currentPage: 1,
      ),
    );
  }

  // Method to fetch the next page of tasks
  Future<void> _fetchNextPage(FetchNextPageEvent event, Emitter<TasksState> emit) async {
    if (state.hasReachedEnd) {
      return;
    }

    emit(state.copyWith(status: TasksStatus.loadingMore));
    final List<Task> tasks = await getTasks(page: state.currentPage);

    emit(
      state.copyWith(
        status: TasksStatus.success,
        tasks: List.of(state.tasks)..addAll(tasks),
        hasReachedEnd: tasks.isEmpty,
        currentPage: state.currentPage + 1,
      ),
    );
  }
}
