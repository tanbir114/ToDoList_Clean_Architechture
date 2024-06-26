// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do_list/features/todo/domain/entities/todo.dart';
import 'package:to_do_list/features/todo/domain/usecases/add.dart';
import 'package:to_do_list/features/todo/domain/usecases/edit.dart';
import 'package:to_do_list/shared/utils/usecase.dart';

import '../../domain/usecases/delete.dart';
import '../../domain/usecases/list.dart';

class TodoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final AddTodoUseCase addTodoUseCase;
  final ListTodoUseCase listTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final EditTodoUseCase editTodoUseCase;

  TodoController({
    required this.addTodoUseCase,
    required this.listTodoUseCase,
    required this.deleteTodoUseCase,
    required this.editTodoUseCase,
  });

  Future<void> addTodo() async {
    final results = await addTodoUseCase(Params(
      Todo(
        id: generateRandomId(10),
        text: titleController.text.trim(),
        description: descriptionController.text.trim(),
      ),
    ));
    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (todo) {
      // clear form
      titleController.clear();
      descriptionController.clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Stream<List<Todo>> listTodo() async* {
    final results = await listTodoUseCase(NoParams());
    yield* results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
      return Stream.value([]);
    }, (todo) {
      return todo;
    });
  }

  Future<void> deleteTodo(Todo todo) async {
    final results = await deleteTodoUseCase(Params(todo));
    results.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (r) => Get.snackbar("Success", "Todo deleted successfully"),
    );
  }

  Future<void> editTodo(Todo todo) async {
    final results = await editTodoUseCase(Params(todo));
    results.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (r) => Get.snackbar("Success", "Todo edited successfully"),
    );
  }
}
