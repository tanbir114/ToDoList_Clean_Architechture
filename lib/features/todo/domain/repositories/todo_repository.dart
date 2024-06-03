import 'package:dartz/dartz.dart';
import 'package:to_do_list/features/todo/domain/entities/todo.dart';
import 'package:to_do_list/shared/errors/failure.dart';

abstract class TodoRepository {
  // Add todo
  Future<Either<Failure, Todo>> add(Todo todo);
  //Edit todo
  Future<Either<Failure, Todo>> edit(Todo todo);
  //Delete
  Future<Either<Failure, Todo>> delete(Todo todo);
  //Get All toda
  Future<Either<Failure,List<Todo>>> getAll();
}
