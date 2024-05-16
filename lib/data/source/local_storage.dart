import 'dart:convert';

import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences sharedPref;
  final int pageSize;

  LocalStorage({
    required this.sharedPref,
    this.pageSize = 10,
  });

  List<Task> loadTasksPage(int page) {
    final List<Task> allTasks = _loadAllTasks();

    return allTasks.sublist(page * pageSize, (page + 1) * pageSize);
  }

  void updateTask(Task task) {
    removeTask(task.id);
    saveTask(task);
  }

  void saveTask(Task task) {
    final String jsonString = json.encode(task.toMap());

    // Получаем текущий список задач из хранилища
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    // Добавляем новую задачу в конец списка
    jsonList.add(jsonString);

    // Сохраняем обновленный список задач в хранилище
    sharedPref.setStringList('tasks', jsonList);
  }

  void removeTask(int id) {
    final List<Task> allTasks = _loadAllTasks();

    allTasks.removeWhere((Task task) => task.id == id);

    final List<String> jsonList = allTasks.map((Task task) => json.encode(task.toMap())).toList();
    // Сохраняем обновленный список задач в хранилище
    sharedPref.setStringList('tasks', jsonList);
  }

  List<Task> _loadAllTasks() {
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    return jsonList.map((String str) => Task.fromMap(json.decode(str))).toList();
  }
}