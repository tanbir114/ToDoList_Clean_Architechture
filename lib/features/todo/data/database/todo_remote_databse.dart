import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';

abstract class TodoRemoteDatabase {
  Future<Todo> addTodo(Todo todo);
  Future<Todo> editTodo(Todo todo);
  Future<Todo> deleteTodo(Todo todo);
  Stream<List<Todo>> listTodos(String uid, String query, bool ascending);
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
  Stream<List<Todo>> listTodos(
      String uid, String query, bool ascending) async* {
    if (query != "kdfnvckljasnvkjasnvnv asjnvkajdnan jfaopdjf oj") {
      yield* FirebaseFirestore.instance
          .collection('todos')
          .where('uid', isEqualTo: uid)
          .where('text', isEqualTo: query)
          .snapshots()
          .map((snapshot) {
        print("kkkkkkkkkkkkkkkk + ${snapshot}");
        return snapshot.docs.map((doc) {
          return Todo.fromMap(doc.data());
        }).toList();
      });
    } else {
      yield* FirebaseFirestore.instance
          .collection('todos')
          .where('uid', isEqualTo: uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          print("jjjjjjjjjjjjjjjjj + ${query}");
          return Todo.fromMap(doc.data());
        }).toList();
      });
    }
  }

  // @override
  // Stream<List<Todo>> sortTodos(String uid,
  //     {String sortBy = 'dateTime', bool ascending = true}) async* {
  //   yield* FirebaseFirestore.instance
  //       .collection('todos')
  //       .where('uid', isEqualTo: uid)
  //       .orderBy(sortBy, descending: !ascending)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Todo.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // @override
  // Stream<List<Todo>> searchTodos(String uid, String query) async* {
  //   print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ${query} ${uid}");
  //   yield* FirebaseFirestore.instance
  //       .collection('todos')
  //       .where('uid', isEqualTo: uid)
  //       .where('text', isGreaterThanOrEqualTo: query)
  //       .where('text', isLessThanOrEqualTo: query + '\uf8ff')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => Todo.fromMap(doc.data())).toList();
  //   });
  // }
}
