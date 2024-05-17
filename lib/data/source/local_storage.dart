import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_to_do/data/source/data_source.dart';
import 'package:bloc_to_do/domain/entity/task.dart';

class LocalStorage extends DataSource {
  final SharedPreferences sharedPref;
  final int pageSize;

  const LocalStorage({
    required this.sharedPref,
    this.pageSize = 10,
  });

  @override
  Future<List<Task>> loadTasksPage({required int page}) async {
    // Load all tasks from storage
    final List<Task> allTasks = _loadAllTasks();

    // Calculate the starting index of tasks for the requested page
    final int tasksCount;
    final int lengthOfLoadedTasks = page * pageSize;

    // Determine the number of tasks to load for the requested page
    if ((page + 1) * pageSize > allTasks.length) {
      tasksCount = allTasks.length - lengthOfLoadedTasks;
    } else {
      tasksCount = pageSize;
    }

    // Return the sublist of tasks for the requested page
    return allTasks.sublist(lengthOfLoadedTasks, lengthOfLoadedTasks + tasksCount);
  }

  @override
  Future<void> saveTask({required Task task}) async {
    // Encode the task to JSON
    final String jsonString = json.encode(task.toMap());

    // Get the current list of tasks from storage
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    // Add the new task to the end of the list
    jsonList.add(jsonString);

    // Save the updated list of tasks to storage
    await sharedPref.setStringList('tasks', jsonList);
  }

  @override
  Future<void> removeTask({required String id}) async {
    // Get the current list of tasks from storage
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    // Remove the task with the specified ID from the list
    jsonList.removeWhere((String str) => json.decode(str)['id'] == id);

    // Save the updated list of tasks to storage
    await sharedPref.setStringList('tasks', jsonList);
  }

  // Load all tasks from storage and convert them to Task objects
  List<Task> _loadAllTasks() {
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    return jsonList.map((String str) => Task.fromMap(json.decode(str))).toList();
  }
}
