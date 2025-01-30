import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';

import 'app/module/home/view.dart';
import 'app/module/home/binding.dart';
import 'app/data/services/storage/service.dart';
import 'package:getx_todo_list/app/module/detail/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        primaryColor: const Color(0xFF2196F3),


        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
