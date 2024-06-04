import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/authentication/presentation/binding/auth_binding.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';
import 'features/todo/presentation/bindings/todo_binding.dart';
import 'features/todo/presentation/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  TodoBinding().dependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo Clean',
      debugShowCheckedModeBanner: false,
      initialRoute: '/signIn',
      getPages: [
        GetPage(name: '/', page: () => const HomePage(), binding: TodoBinding()),
        GetPage(name: '/signIn', page: () => SignInPage(), binding: AuthBinding()),
        GetPage(name: '/signUp', page: () => SignUpPage(), binding: AuthBinding()),
      ],
    );
  }
}
