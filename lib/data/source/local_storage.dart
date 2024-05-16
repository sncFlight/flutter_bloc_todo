import 'dart:convert';

import 'package:bloc_to_do/data/source/data_source.dart';
import 'package:bloc_to_do/domain/entity/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends DataSource {
  final SharedPreferences sharedPref;
  final int pageSize;

  const LocalStorage({
    required this.sharedPref,
    this.pageSize = 10,
  });

  @override
  Future<List<Task>> loadTasksPage({required int page}) async {
    final List<Task> allTasks = _loadAllTasks();

    return allTasks.sublist(page * pageSize, (page + 1) * pageSize);
  }

  @override
  Future<void> updateTask(Task task) async {
    await removeTask(task.id);
    await saveTask(task);
  }

  @override
  Future<void> saveTask(Task task) async {
    final String jsonString = json.encode(task.toMap());

    // Получаем текущий список задач из хранилища
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    // Добавляем новую задачу в конец списка
    jsonList.add(jsonString);

    // Сохраняем обновленный список задач в хранилище
    await sharedPref.setStringList('tasks', jsonList);
  }

  @override
  Future<void> removeTask(int id) async {
    final List<Task> allTasks = _loadAllTasks();

    allTasks.removeWhere((Task task) => task.id == id);

    final List<String> jsonList = allTasks.map((Task task) => json.encode(task.toMap())).toList();
    // Сохраняем обновленный список задач в хранилище
    await sharedPref.setStringList('tasks', jsonList);
  }

  List<Task> _loadAllTasks() {
    final List<String> jsonList = sharedPref.getStringList('tasks') ?? [];

    return jsonList.map((String str) => Task.fromMap(json.decode(str))).toList();
  }
}