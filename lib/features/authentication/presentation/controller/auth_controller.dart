import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/entities/user.dart';

import 'package:to_do_list_clean_architecture/features/authentication/domain/usecases/get_current_uid.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/usecases/is_sign_in.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/usecases/sign_in.dart';

import '../../../../shared/utils/random_id.dart';
import '../../../../shared/utils/usecase.dart';
import '../../domain/usecases/get_create_current_user.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;

  AuthController({
    required this.getCreateCurrentUserUseCase,
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.signUpUseCase,
  });

  var isSignedIn = false.obs;
  var uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    signOut();
    isSignIn();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    print(nameController.text.trim());
    print(passwordController.text);
    print(emailController.text);
    final results = await signInUseCase(Params(
      ToDoUser(
        name: '',
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        uid: '',
      ),
    ));
    print(results);
    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (todouser) async {
      // clear form
      nameController.clear();
      passwordController.clear();
      emailController.clear();
      await isSignIn();
      Get.snackbar("Success", "Signed in successfully");
    });
  }

  Future<void> signOut() async {
    final results = await signOutUseCase(NoParams());
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (r) async {
      isSignedIn.value = false;
      uid.value = '';
      // Get.offAllNamed('/signIn');
      // Get.snackbar("Success", "Signed out successfully");
    });
  }

  Future<void> signUp() async {
    final results = await signUpUseCase(Params(
      ToDoUser(
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        uid: generateRandomId(10),
      ),
    ));

    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (r) async {
      await isSignIn();
      Get.snackbar("Success", "Signed up successfully");
    });
  }

  Future<void> getCreateCurrentUser() async {
    final results = await getCreateCurrentUserUseCase(Params(
      ToDoUser(
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        uid: generateRandomId(10),
      ),
    ));

    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (r) {
      // clear form
      nameController.clear();
      passwordController.clear();
      emailController.clear();
      Get.snackbar("Success", "User created successfully");
    });
  }

  Future<void> getCurrentUid() async {
    final results = await getCurrentUidUseCase(NoParams());

    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (uid) {
      Get.snackbar("Success", "Current User ID: $uid");
    });
  }

  Future<void> isSignIn() async {

    final results = await isSignInUseCase(NoParams());


    results.fold((failure) {
      isSignedIn.value = false;
      uid.value = '';
    }, (signedIn) async {
      isSignedIn.value = signedIn;
      if (signedIn) {
        final uidResult = await getCurrentUidUseCase(NoParams());
        uidResult.fold((failure) {
          Get.snackbar("Error", failure.message);
        }, (userId) {
          uid.value = userId;
        });
      }
    });
  }
}
