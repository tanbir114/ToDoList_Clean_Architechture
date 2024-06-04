import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/todo/data/database/todo_remote_databse.dart';
import 'package:to_do_list_clean_architecture/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/usecases/add.dart';
import 'package:to_do_list_clean_architecture/features/todo/presentation/controller/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRemoteDatabase>(() => TodoRemoteDatabseImpl());
    Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(remoteDatabase: Get.find()));
    Get.lazyPut(() => AddTodoUseCase(Get.find()));
    Get.lazyPut(() => TodoController(addTodoUseCase: Get.find())); // In GetX, Get.lazyPut() is used to register dependencies lazily. This means that the dependency will only be instantiated the first time it's requested (i.e., when it's used for the first time). Subsequent requests for the same dependency will return the previously created instance.
  }
}
