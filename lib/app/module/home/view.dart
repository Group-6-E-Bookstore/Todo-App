import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/module/home/controller.dart';
import 'package:todo_app/app/module/home/widgets/add_card.dart';
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
                      .map((element) => TaskCard(task: element))
                      .toList(),
                  AddCard(), // Fixed to add const
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
