import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/authentication/presentation/controller/auth_controller.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';
import '../controller/todo_controller.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    // var des = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Clean Architecture'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Search Todos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              controller.des.value = !controller.des.value;
              controller.listTodo(
                controller.searchController.text.trim().isEmpty
                    ? "kdfnvckljasnvkjasnvnv asjnvkajdnan jfaopdjf oj"
                    : controller.searchController.text.trim(),
                controller.des.value,
              );
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: controller.listTodo(
                controller.searchController.text.trim().isEmpty
                    ? "kdfnvckljasnvkjasnvnv asjnvkajdnan jfaopdjf oj"
                    : controller.searchController.text.trim(),
                controller.des.value,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final todos = snapshot.data!;
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text("No todos found"),
                    );
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      bool isToday =
                          isSameDay(todos[index].dateTime, DateTime.now());
                      Color tileColor = isToday ? Colors.green : Colors.white;

                      return ListTile(
                        tileColor: tileColor,
                        title: Text(todos[index].text),
                        subtitle: Text(
                          "${todos[index].description}\nCreated on: ${DateFormat('yyyy-MM-dd – kk:mm').format(todos[index].dateTime)}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                controller.titleController.text =
                                    todos[index].text;
                                controller.descriptionController.text =
                                    todos[index].description;
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: double.maxFinite,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          key: controller.formKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller:
                                                    controller.titleController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Title is required';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Title',
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: TextFormField(
                                                  controller: controller
                                                      .descriptionController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Description is required';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Description',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (controller
                                                        .formKey.currentState!
                                                        .validate()) {
                                                      controller.editTodo(
                                                        Todo(
                                                          id: todos[index].id,
                                                          text: controller
                                                              .titleController
                                                              .text
                                                              .trim(),
                                                          description: controller
                                                              .descriptionController
                                                              .text
                                                              .trim(),
                                                          uid: authController
                                                              .uid.value,
                                                          dateTime:
                                                              DateTime.now(),
                                                        ),
                                                      );
                                                      // pop the bottom sheet
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child:
                                                      const Text('Edit Todo'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                controller.deleteTodo(todos[index]);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            controller: controller.descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.addTodo();
                                // pop the bottom sheet
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
