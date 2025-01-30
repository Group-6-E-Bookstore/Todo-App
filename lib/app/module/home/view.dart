import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/values/colors.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/module/home/controller.dart';
import 'package:todo_app/app/module/home/widgets/add_card.dart';
import 'package:todo_app/app/module/home/widgets/add_dialog.dart';
import 'package:todo_app/app/module/home/widgets/task_card.dart'; // Ensure TaskCard is imported

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(4.0), // Optional: Adds padding
          children: [
            Text(
              'My List',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold, // Fixed the bold weight issue
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,                
                shrinkWrap: true, // Allows GridView to adjust to its content
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                padding: const EdgeInsets.all(8.0),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                        data: element ,
                        onDragStarted:()=> controller.changeDeleting(true) ,
                        onDraggableCanceled: (_, __) =>controller.changeDeleting(false),
                        onDragEnd: (_)=> controller.changeDeleting(false),
                        feedback: Opacity(opacity: 0.8,
                        child: TaskCard(task: element)) ,
                        child: TaskCard(task: element)))
                         
                      .toList(),
                  AddCard(), // Fixed to add const
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton:DragTarget(builder : (_,__,___){
        return  Obx(
          () =>  FloatingActionButton(
            backgroundColor: controller.deleting.value ?Colors.red : blue,
            onPressed: () {
              if(controller.tasks.isEmpty){
                 Get.to(()=> AddDialog(), transition: Transition.downToUp);

              } else{
                EasyLoading.showInfo('please create your task type');
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add)
          )
        );
      },
      onAccept:(Task task){
        controller.deleteTask(task);
        EasyLoading.showSuccess("Delete success");
      } ,
      )

    );
  }
}
