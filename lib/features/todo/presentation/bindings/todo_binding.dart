import 'package:get/get.dart';
import 'package:to_do_list/features/todo/presentation/controller/todo_controller.dart';

class TodoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> TodoController(addTodoUseCase: Get.find()));
  }

}