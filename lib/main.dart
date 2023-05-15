
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_task_app/model/QuickTask.dart';
import 'package:quick_task_app/screen/splash_screen.dart';



Box? box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuickTaskAdapter());
  await Hive.openBox('QuickTaskBox');




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
