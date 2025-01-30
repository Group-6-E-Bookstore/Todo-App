import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/app/core/utils/extension.dart';
import 'package:todo_app/app/module/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty ? Column(
        children: [
          Image.asset('assets/task.png',
          fit: BoxFit.cover,
          width: 65.0.wp,
          ),
          Text('Add Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0.sp,

          ),)
        ],
      ):ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...homeCtrl.doingTodos.map((Element) => 
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 3.0.wp,
              horizontal: 9.0.wp,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((StateS) => Colors.grey),
                    value: Element['done'],
                    onChanged: (Value){
                      homeCtrl.doneTodo( Element['title']);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0.wp),
                  child: Text(
                    Element['title'],
                  overflow: TextOverflow.ellipsis,),
                )
              ],
            ),
          )
          ).toList(),
          if(homeCtrl.doingTodos.isNotEmpty) Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: const Divider(thickness: 2,),
          )
        ],
      )
       );
  }
}