import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/bindings/todo_binding.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=>HomePage(), binding: TodoBinding())
      ], 
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('To Do List'), // Set the title of the app bar
      //   ),
      //   body: const Center(
      //     child: Text('Hello'),
      //   ),
      // ),
    );
  }
}
