import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_clean_architecture/features/authentication/presentation/controller/auth_controller.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/todo.dart';
import '../controller/todo_controller.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Todo Clean Architecture', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout , color: Colors.black),
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
  decoration: InputDecoration(
    labelText: 'Search Todos',
    prefixIcon: Icon(Icons.search, color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Border color
        width: 1.0, // Border width
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: Colors.grey, // Border color
        width: 1.0, // Border width
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.blue, 
        width: 2.0, 
      ),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    fillColor: Colors.grey[200],
    filled: true,

  ),
)
          ),
          Obx(() => IconButton(
                icon: Icon(controller.des.value ? Icons.sort : Icons.sort_by_alpha),
                onPressed: () {
                  controller.toggleSortDirection();
                },
              )),
          Expanded(
            child:StreamBuilder(
                stream: controller.listTodo(
                  controller.searchController.text.trim().isEmpty
                      ? "kdfnvckljasnvkjasnvnv asjnvkajdnan jfaopdjf oj"
                      : controller.searchController.text.trim(),
                ),
                builder: (context, snapshot) {
                   if (snapshot.hasData) {
                    List<Todo> todos = snapshot.data as List<Todo>;
                    if (todos.isEmpty) {
                      return const Center(
                        child: Text("No todos found"),
                      );
                    }
                    return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final newindex = controller.des.value ? index : todos.length - index-1;                 
                  final todo = todos[newindex];
                  final isDeadlineToday = todo.deadline != null &&
                      DateTime.now().year == todo.deadline!.year &&
                      DateTime.now().month == todo.deadline!.month &&
                      DateTime.now().day == todo.deadline!.day;
              
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(.8),
                    surfaceTintColor: Colors.amber,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: isDeadlineToday ? Colors.red : Colors.yellow,
                    child: ListTile(
                      title: Text(todo.text),
                      subtitle: Text(
                "${todo.description}\n${todo.deadline != null ? "Deadline: ${DateFormat('MMM d, yyyy-kk:mm').format(todo.deadline!)}" : ""}",),
              
                      trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
              IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  controller.titleController.text =
                                      todos[newindex].text;
                                  controller.descriptionController.text =
                                      todos[newindex].description;
                                  if (todos[newindex].deadline != null) {
                                    controller.deadlineController.text =
                                        todos[newindex].deadline!.toIso8601String();
                                  }
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
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: TextFormField(
                                                    controller: controller.deadlineController,
                                                    readOnly: true,
                                                    onTap: () async {
                                                      final DateTime? picked = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime.now(),
                                                        lastDate: DateTime(2100),
                                                      );
                                                      if (picked != null) {
                                                        final TimeOfDay? time = await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay.now(),
                                                        );
                                                        if (time != null) {
                                                          controller.deadlineController.text = DateTime(
                                                            picked.year,
                                                            picked.month,
                                                            picked.day,
                                                            time.hour,
                                                            time.minute,
                                                          ).toIso8601String();
                                                        }
                                                      }
                                                    },
                                                    decoration: const InputDecoration(
                                                      labelText: 'Deadline',
                                                      suffixIcon: Icon(Icons.calendar_today),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (controller.formKey.currentState!.validate()) {
                                                      Get.back();
                                                      controller.editTodo(
                                                        todos[newindex],
                                                      );
                                                    }
                                                  },
                                                  child: const Text('Update Todo'),
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
                                  controller.deleteTodo(
                                    todos[newindex],
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading todos"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
                ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.titleController.clear();
          controller.descriptionController.clear();
          controller.deadlineController.clear();
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            controller: controller.deadlineController,
                            readOnly: true,
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  controller.deadlineController.text = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                    time.hour,
                                    time.minute,
                                  ).toIso8601String();
                                }
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Deadline',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              Get.back();
                              controller.addTodo();
                            }
                          },
                          child: const Text('Add Todo'),
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
