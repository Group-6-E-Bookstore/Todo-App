import 'dart:convert';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/keys.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // {
  //   'tasks': [
  //     {
  //       'title': 'Work',
  //       'color': '#ff123456',
  //       'icon': 0xe123
  //     }
  //   ]
  // }

  List<Task> readTasks() {
    var tasks = <Task>[];
    try {
      var jsonString = _storage.read<String>(taskkey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        tasks = jsonList
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error reading tasks: $e');
    }
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    try {
      final List<Map<String, dynamic>> jsonList =
          tasks.map((task) => task.toJson()).toList();
      _storage.write(taskkey, jsonEncode(jsonList));
    } catch (e) {
      print('Error writing tasks: $e');
    }
  }
}
