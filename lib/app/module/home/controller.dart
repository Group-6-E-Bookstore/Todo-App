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
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task =Rx<Task?>(null);

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
    editCtrl.dispose();
    super.onClose();
 // Dispose the controller to free resources
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }
  void changeDeleting(bool value){
    deleting.value = value;
  }
  void changeTask(Task? select){
    task.value=select;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  }

  updateTask(Task task, String title){
    var todos = task.todos?? [];
    if(containeTodo(todos, title)){
      return false ;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }
  bool containeTodo(List todos, String title ){
    return todos.any((element)=> element['title']==title   );
  }
}
