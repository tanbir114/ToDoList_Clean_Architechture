import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../todo/presentation/pages/home.dart';
import '../controller/auth_controller.dart';
import '../widgets/common.dart';

class SignInPage extends GetView<AuthController> {
  final GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: Obx(() {
        if (controller.isSignedIn.value) {
          return HomePage();
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
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 120,
            child: Image.asset("assets/images/notebook.png"),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  hintText: 'Enter your email', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Enter your Password', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              submitSignIn();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed("/signUp");
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitSignIn() {
    if (controller.emailController.text.isNotEmpty &&
        controller.passwordController.text.isNotEmpty) {
      print("Logging in with:");
      print(controller.emailController.text);
      print(controller.passwordController.text);
      controller.signIn();
    } else {
      snackBarError(
        msg: "Please fill in both fields",
        scaffoldState: _scaffoldGlobalKey,
      );
    }
  }
}
