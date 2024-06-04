import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/entities/todo.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

import '../database/todo_remote_databse.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatabase remoteDatabase;
  TodoRepositoryImpl({required this.remoteDatabase});

  @override
  Future<Either<Failure, Todo>> add(Todo todo) async {
    try {
      final result = await remoteDatabase.addTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("we could not add todo"));
    }
  }

  @override
  Future<Either<Failure, Todo>> delete(Todo todo) async {
    try {
      final result = await remoteDatabase.deleteTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("we could not delete todo"));
    }
  }

  @override
  Future<Either<Failure, Todo>> edit(Todo todo) async {
    try {
      final result = await remoteDatabase.editTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("we could not edit todo"));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Todo>>>> getAll(String uid) async {
    try {
      final result = await remoteDatabase.listTodos(uid);
      return Right(result);
    } catch (e) {
      return Left(Failure("we could not fetch the todos from the database"));
    }
  }
}
