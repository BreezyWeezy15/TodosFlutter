import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todos_app/db/todos_helper.dart';
import 'package:todos_app/ui/splash_page.dart';

TodosHelper todosHelper = TodosHelper.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await AndroidAlarmManager.initialize();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
