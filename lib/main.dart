
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_database_testing_hive/QuickTask.dart';
import 'package:local_database_testing_hive/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'service/notification.dart';


Box? box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuickTaskAdapter());
  await Hive.openBox('QuickTaskBox');
 tz.initializeTimeZones();

  NotificationService().initNotification();

  runApp(const QuickTaskApp());
}

class QuickTaskApp extends StatelessWidget {
  const QuickTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Task App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const SplashScreen());
  }
}
