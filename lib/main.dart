import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/bindings/todo_binding.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/pages/home.dart';
import 'package:to_do_list_clean_architecture/features/authentication/presentation/binding/auth_binding.dart'
    as di;
import 'package:to_do_list_clean_architecture/on_generate_route.dart';

import 'features/authentication/presentation/cubit/auth/auth_cubit.dart';
import 'features/authentication/presentation/cubit/user/user_cubit.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => di.sl<UserCubit>(),
        ),
      ],
      child: GetMaterialApp(
        title: 'To Do List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/signin': (context) => const SignInPage(),
          '/home': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map;
            return HomePageWithBindings(uid: args['uid']);
          },
        },
        onGenerateRoute: OnGenerateRoute.route,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, '/home',
              arguments: {'uid': state.uid});
        } else if (state is UnAuthenticated) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class HomePageWithBindings extends StatelessWidget {
  final String uid;
  HomePageWithBindings({required this.uid});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    TodoBinding().dependencies();

    return HomePage(uid: uid);
  }
}

