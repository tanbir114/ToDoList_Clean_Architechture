import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../todo/presentation/pages/home.dart';
import '../controller/auth_controller.dart';
import '../widgets/common.dart';

class SignUpPage extends GetView<AuthController> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Obx(() {
        if (controller.isSignedIn.value) {
          return const HomePage();
        } else {
          return _bodyWidget(context);
        }
      }),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Get.offAllNamed('/signIn');
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(.6)),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your Password',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              submitSignUp();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text(
                "Create New Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void submitSignUp() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      controller.nameController.text = _usernameController.text.trim();
      controller.emailController.text = _emailController.text.trim();
      controller.passwordController.text = _passwordController.text.trim();
      controller.signUp();
    } else {
      snackBarError(
        msg: "Please fill in all fields",
        scaffoldState: _globalKey,
      );
    }
  }
}
