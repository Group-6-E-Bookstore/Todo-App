import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:todo_app/app/core/utils/extension.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/module/home/controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/app/core/utils/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons(); // Ensure this function returns a List<Icon>
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your title';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 3.0.wp),
                  Wrap(
                    spacing: 2.0.wp,
                    children: icons.map((e) {
                      final index = icons.indexOf(e);
                      return ChoiceChip(
                        selectedColor: Colors.grey[200],
                        pressElevation: 0,
                        backgroundColor: Colors.white,
                        label: e,
                        selected: homeCtrl.chipIndex.value == index,
                        onSelected: (bool selected) {
                          homeCtrl.chipIndex.value = selected ? index : 0;
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 3.0.wp),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        int icon =
                            icons[homeCtrl.chipIndex.value].icon!.codePoint;
                        Color iconColor =
                            icons[homeCtrl.chipIndex.value].color!;
                        String color = iconColor.value.toRadixString(16);
                        var task = Task(
                          title: homeCtrl.editCtrl.text,
                          icon: icon,
                          color: color,
                        );

                        // Add task and provide feedback
                        if (homeCtrl.addTask(task)) {
                          EasyLoading.showSuccess('Create success');
                        } else {
                          EasyLoading.showError('Duplicated Task');
                        }

                        // Close the dialog
                        Get.back();
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
