import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


import '../../data/database/user_remote_database.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../domain/usecases/get_current_uid.dart';
import '../../domain/usecases/is_sign_in.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/get_create_current_user.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDatabase>(() => AuthRemoteDatabaseImpl(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => GetCurrentUidUseCase(Get.find()));
    Get.lazyPut(() => IsSignInUseCase(Get.find()));
    Get.lazyPut(() => SignInUseCase(Get.find()));
    Get.lazyPut(() => SignOutUseCase(Get.find()));
    Get.lazyPut(() => SignUpUseCase(Get.find()));
    Get.lazyPut(() => GetCreateCurrentUserUseCase(Get.find()));
    Get.lazyPut(() => AuthController(
      getCreateCurrentUserUseCase: Get.find(),
      getCurrentUidUseCase: Get.find(),
      isSignInUseCase: Get.find(),
      signInUseCase: Get.find(),
      signOutUseCase: Get.find(),
      signUpUseCase: Get.find(),
    ));
  }
}

