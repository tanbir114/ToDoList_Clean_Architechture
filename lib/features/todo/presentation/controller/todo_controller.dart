// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/usecases/add.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/usecases/edit.dart';
import 'package:to_do_list_clean_architecture/shared/utils/usecase.dart';

import '../../../../shared/utils/random_id.dart';
import '../../../authentication/presentation/controller/auth_controller.dart';
import '../../domain/usecases/delete.dart';
import '../../domain/usecases/list.dart';
// import '../../domain/usecases/search.dart';
// import '../../domain/usecases/sort.dart';

class TodoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  final AddTodoUseCase addTodoUseCase;
  final ListTodoUseCase listTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final EditTodoUseCase editTodoUseCase;
  // final SortUseCase sortUseCase;
  // final SearchUseCase searchUseCase;

  final AuthController authController = Get.find<AuthController>();

  TodoController({
    required this.addTodoUseCase,
    required this.listTodoUseCase,
    required this.deleteTodoUseCase,
    required this.editTodoUseCase,
    // required this.sortUseCase,
    // required this.searchUseCase,
  });

  var des = true.obs;

  // Method to toggle the sort direction
  void toggleSortDirection() {
    des.value = !des.value;
    updateTodoList();
  }

  void updateTodoList() {
    listTodo(); // Make sure this method adapts to the new sort order, possibly by creating a new stream
  }

  Future<void> addTodo() async {
    final uid = authController.uid.value;
    final newTodo = Todo(
      id: generateRandomId(10),
      text: titleController.text.trim(),
      description: descriptionController.text.trim(),
      uid: uid,
      dateTime: DateTime.now(),
    );

    final results = await addTodoUseCase(Params(newTodo));
    results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (todo) {
      titleController.clear();
      descriptionController.clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Stream<List<Todo>> listTodo({String? query, bool ascending = true}) async* {
    print(
        "Todo controller called with uid:, query: $query, ascending: $ascending");
    final results = await listTodoUseCase(
      authController.uid.value,
      query!,
      ascending,
    );
    print(results);
    yield* results.fold((failure) {
      print(failure.message);
      Get.snackbar("Error", failure.message);
      return Stream.value([]);
    }, (todo) {
      return todo;
    });
  }

  // Stream<List<Todo>> sortTodosByDate() async* {
  //   final results = await sortUseCase(Params(authController.uid.value));
  //   yield* results.fold((failure) {
  //     print(failure.message);
  //     Get.snackbar("Error", failure.message);
  //     return Stream.value([]);
  //   }, (todo) {
  //     return todo;
  //   });
  // }

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

  // Stream<List<Todo>> searchTodos(String query) async* {
  //   print("sssssssssssssssss ${query}");
  //   final results = await searchUseCase(authController.uid.value, query);
  //   print(results);
  //   print(results.length);
  //   yield* results.fold((failure) {
  //     print(failure.message);
  //     Get.snackbar("Error", failure.message);
  //     return Stream.value([]);
  //   }, (todo) {
  //     return todo;
  //   });
  // }
}
