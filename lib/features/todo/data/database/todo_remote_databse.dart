import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';

abstract class TodoRemoteDatabase {
  // Add todo
  Future<Todo> addTodo(Todo todo);
  //Edit todo
  Future<Todo> editTodo(Todo todo);
  //Delete
  Future<Todo> deleteTodo(Todo todo);
  //Get All toda
  Stream<List<Todo>> listTodos(String uid);
}

class TodoRemoteDatabseImpl implements TodoRemoteDatabase {
  @override
  Future<Todo> addTodo(Todo todo) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todo.id)
        .set(todo.toMap());
    return todo;
  }

  @override
  Future<Todo> deleteTodo(Todo todo) async {
    await FirebaseFirestore.instance.collection('todos').doc(todo.id).delete();
    return todo;
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todo.id)
        .update(todo.toMap());
    return todo;
  }

  @override
  Stream<List<Todo>> listTodos(String uid) async* {
    yield* FirebaseFirestore.instance
        .collection('todos')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromMap(doc.data())).toList();
    });
  }
}
