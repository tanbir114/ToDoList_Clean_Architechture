import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/random_id.dart';
import '../../../../shared/utils/usecase.dart';
import '../../../authentication/presentation/controller/auth_controller.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add.dart';
import '../../domain/usecases/delete.dart';
import '../../domain/usecases/edit.dart';
import '../../domain/usecases/list.dart';

class TodoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final deadlineController = TextEditingController(); // Add this line

  final AddTodoUseCase addTodoUseCase;
  final ListTodoUseCase listTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final EditTodoUseCase editTodoUseCase;

  final AuthController authController = Get.find<AuthController>();

  TodoController({
    required this.addTodoUseCase,
    required this.listTodoUseCase,
    required this.deleteTodoUseCase,
    required this.editTodoUseCase,
  });

  var des = true.obs;

  void toggleSortDirection() {
    des.value = !des.value;
    print(des.value);
    updateTodoList();
  }

  void updateTodoList() {
    listTodo("kdfnvckljasnvkjasnvnv asjnvkajdnan jfaopdjf oj");
    update();
  }

  Future<void> addTodo() async {
    final uid = authController.uid.value;
    final newTodo = Todo(
      id: generateRandomId(10),
      text: titleController.text.trim(),
      description: descriptionController.text.trim(),
      uid: uid,
      dateTime: DateTime.now(),
      deadline: deadlineController.text.isNotEmpty
          ? DateTime.parse(deadlineController.text)
          : null, // Add this line
    );

    final results = await addTodoUseCase(Params(newTodo));
    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (todo) {
      titleController.clear();
      descriptionController.clear();
      deadlineController.clear(); // Add this line
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Future<void> editTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      text: titleController.text.trim(),
      description: descriptionController.text.trim(),
      uid: todo.uid,
      dateTime: todo.dateTime,
      deadline: deadlineController.text.isNotEmpty
          ? DateTime.parse(deadlineController.text)
          : null, // Add this line
    );

    final results = await editTodoUseCase(Params(updatedTodo));
    results.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (r) => Get.snackbar("Success", "Todo edited successfully"),
    );
  }

  Stream<List<Todo>> listTodo(String query) async* {
  print("Todo controller called with uid:, query: $query");
  final results = await listTodoUseCase(
    authController.uid.value,
    query,
  );
  
  yield* results.fold(
    (failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
      return Stream.value([]);
    }, 
    (todoStream) async* {
      await for (var todos in todoStream) {
        todos.sort((a, b) {
          if (a.deadline == null && b.deadline == null) return 0;
          if (a.deadline == null) return des.value ? 1 : -1;
          if (b.deadline == null) return des.value ? -1 : 1;
          return des.value
              ? b.deadline!.compareTo(a.deadline!)
              : a.deadline!.compareTo(b.deadline!);
        });
        yield todos;
      }
    }
  );
}


  Future<void> deleteTodo(Todo todo) async {
    final results = await deleteTodoUseCase(Params(todo));
    results.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (r) => Get.snackbar("Success", "Todo deleted successfully"),
    );
  }
}
