import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/core/utils/extension.dart';
import 'package:todo_app/app/module/home/controller.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final HomeController homeCtrl;
  final Task task;

  TaskCard({Key? key, required this.task})
      : homeCtrl = Get.find<HomeController>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Validate and convert color with fallback to default (grey) if invalid
    final color = () {
      try {
        return HexColor.fromHex(task.color); // Attempt to parse the color
      } catch (e) {
        print("Invalid color format for task '${task.title}': ${task.color}");
        return Colors.grey; // Fallback color
      }
    }();

    final squareWidth = Get.width - 12.0.wp; // Calculate square width

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Progress Indicator
          StepProgressIndicator(
            totalSteps: task.todos?.length ?? 1, // Ensure totalSteps > 0
            currentStep:
                task.todos?.where((todo) => todo.done == true).length ?? 0,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, Colors.white],
            ),
            unselectedColor: Colors.grey[200]!,
          ),

          // Icon Display
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Icon(
              IconData(task.icon, fontFamily: 'MaterialIcons'),
              color: color,
            ),
          ),

          // Title and Task Details
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Title
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.0.wp),

                // Task Details
                Text(
                  '${task.todos?.length ?? 0} Task(s)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
