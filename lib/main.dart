import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app/module/home/view.dart';
import 'app/module/home/binding.dart'; // Ensure you have this file for bindings
import 'app/data/services/storage/service.dart'; // Ensure you have this file for storage service

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure all services are initialized properly
  await GetStorage.init(); // Initialize GetStorage
  await Get.putAsync(
      () => StorageService().init()); // Initialize your storage service
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // Ensure HomePage exists
      initialBinding: HomeBinding(), // Ensure HomeBinding exists
      builder: EasyLoading.init(), // Initialize EasyLoading
    );
  }
}
