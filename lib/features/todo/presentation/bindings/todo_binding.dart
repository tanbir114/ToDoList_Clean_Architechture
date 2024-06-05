import 'package:get/get.dart';
// import 'package:to_do_list_clean_architecture/features/todo/domain/usecases/sort.dart';

import '../../data/database/todo_remote_databse.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/add.dart';
import '../../domain/usecases/delete.dart';
import '../../domain/usecases/edit.dart';
import '../../domain/usecases/list.dart';
// import '../../domain/usecases/search.dart';
import '../controller/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRemoteDatabase>(() => TodoRemoteDatabseImpl());
    Get.lazyPut<TodoRepository>(
        () => TodoRepositoryImpl(remoteDatabase: Get.find()));
    Get.lazyPut(() => AddTodoUseCase(Get.find()));
    Get.lazyPut(() => ListTodoUseCase(Get.find()));
    Get.lazyPut(() => DeleteTodoUseCase(Get.find()));
    Get.lazyPut(() => EditTodoUseCase(Get.find()));
    // Get.lazyPut(() => SortUseCase(Get.find()));
    // Get.lazyPut(() => SearchUseCase(Get.find()));
    Get.lazyPut(() => TodoController(
          addTodoUseCase: Get.find(),
          listTodoUseCase: Get.find(),
          deleteTodoUseCase: Get.find(),
          editTodoUseCase: Get.find(),
          // sortUseCase: Get.find(),
          // searchUseCase: Get.find()
        ));
    // In GetX, Get.lazyPut() is used to register dependencies lazily. This means that the dependency will only be instantiated the first time it's requested (i.e., when it's used for the first time). Subsequent requests for the same dependency will return the previously created instance.
  }
}
