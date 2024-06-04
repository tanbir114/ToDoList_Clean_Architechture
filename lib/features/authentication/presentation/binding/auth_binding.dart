// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
// import 'package:to_do_list_clean_architecture/features/authentication/data/database/user_remote_database.dart';
// import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';

// import '../../data/repositories/auth_repo_impl.dart';
// import '../../domain/usecases/get_create_current_user.dart';
// import '../../domain/usecases/get_current_uid.dart';
// import '../../domain/usecases/is_sign_in.dart';
// import '../../domain/usecases/sign_in.dart';
// import '../../domain/usecases/sign_out.dart';
// import '../../domain/usecases/sign_up.dart';
// import '../cubit/auth/auth_cubit.dart';
// import '../cubit/user/user_cubit.dart';

// GetIt sl = GetIt.instance;

// Future<void> init() async {
//   //Cubit/Bloc
//   sl.registerFactory<AuthCubit>(() => AuthCubit(
//       isSignInUseCase: sl.call(),
//       signOutUseCase: sl.call(),
//       getCurrentUidUseCase: sl.call()));
//   sl.registerFactory<UserCubit>(() => UserCubit(
//         getCreateCurrentUserUseCase: sl.call(),
//         signInUseCase: sl.call(),
//         signUPUseCase: sl.call(),
//       ));

//   //useCase
//   sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
//       () => GetCreateCurrentUserUseCase(repository: sl.call()));
//   sl.registerLazySingleton<GetCurrentUidUseCase>(
//       () => GetCurrentUidUseCase(repository: sl.call()));
//   sl.registerLazySingleton<IsSignInUseCase>(
//       () => IsSignInUseCase(repository: sl.call()));
//   sl.registerLazySingleton<SignInUseCase>(
//       () => SignInUseCase(repository: sl.call()));
//   sl.registerLazySingleton<SignOutUseCase>(
//       () => SignOutUseCase(repository: sl.call()));
//   sl.registerLazySingleton<SignUPUseCase>(
//       () => SignUPUseCase(repository: sl.call()));

//   //repository
//   sl.registerLazySingleton<AuthRepository>(
//       () => AuthRepositoryImpl(remoteDataSource: sl.call()));

//   //data source
//   sl.registerLazySingleton<AuthRemoteDatabase>(() =>
//       AuthRemoteDatabaseImpl(auth: sl.call(), firestore: sl.call()));

//   //External
//   final auth = FirebaseAuth.instance;
//   final fireStore = FirebaseFirestore.instance;

//   sl.registerLazySingleton(() => auth);
//   sl.registerLazySingleton(() => fireStore);
// }

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

