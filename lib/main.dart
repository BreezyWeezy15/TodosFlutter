import 'package:alarm/alarm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todos_app/db/todos_helper.dart';
import 'package:todos_app/storage/storage_helper.dart';
import 'package:todos_app/ui/splash_page.dart';

import 'languages/codegen_loader.g.dart';
import 'notification_helper.dart';

TodosHelper todosHelper = TodosHelper.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();
  await Alarm.init();
  NotificationHelper.initializePlatformSpecifics();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('it')
      ],
      path: 'assets/languages/',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashPage(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: StorageHelper.getCurrentMode() ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
