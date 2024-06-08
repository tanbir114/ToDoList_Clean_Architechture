import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

abstract class TodoRepository {
  // Add todo
  Future<Either<Failure, Todo>> add(Todo todo);
  //Edit todo
  Future<Either<Failure, Todo>> edit(Todo todo);
  //Delete
  Future<Either<Failure, Todo>> delete(Todo todo);
  //Get All toda
  Future<Either<Failure, Stream<List<Todo>>>> listTodos(String uid, String query);

  //sorting
  // Future<Either<Failure, Stream<List<Todo>>>> sortTodosByDate(String uid,
  //     {String sortBy = 'dateTime', bool ascending = true});
  // // Search
  // Future<Either<Failure, Stream<List<Todo>>>> searchTodos(
  //     String uid, String query);
}
