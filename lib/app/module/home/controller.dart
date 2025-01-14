import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;

  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    try {
      final loadedTasks = taskRepository.readTasks();
      tasks.assignAll(loadedTasks);
      ever(tasks, (_) => taskRepository.writeTasks(tasks.toList()));
    } catch (e) {
      print('Error initializing tasks: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    editCtrl.dispose(); // Dispose the controller to free resources
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }
}
