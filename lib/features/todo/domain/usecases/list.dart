import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ListTodoUseCase {
  final TodoRepository repository;
  ListTodoUseCase(this.repository);

  Future<Either<Failure, Stream<List<Todo>>>> call(
      String uid, String query) {
   return repository.listTodos(uid, query);
  }
}
