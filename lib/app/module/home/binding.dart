import 'package:get/get.dart';
import 'package:todo_app/app/data/services/storage/repository.dart';
import 'package:todo_app/app/module/home/controller.dart';
import 'package:todo_app/app/data/provider/task.dart/provider.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
