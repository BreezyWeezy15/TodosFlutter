import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todos_app/db/todos_helper.dart';
import 'package:todos_app/storage/storage_helper.dart';
import 'package:todos_app/ui/splash_page.dart';

import 'notification_helper.dart';

TodosHelper todosHelper = TodosHelper.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //await AndroidAlarmManager.initialize();
  await Alarm.init();
  NotificationHelper.initializePlatformSpecifics();
  runApp( GetMaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    theme: ThemeData.light(),
    themeMode: StorageHelper.getCurrentMode() ? ThemeMode.dark : ThemeMode.light,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
