import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';
import '../entities/todo.dart';

class ListTodoUseCase {
  final TodoRepository repository;
  ListTodoUseCase(this.repository);

  Future<Either<Failure, Stream<List<Todo>>>> call(
      String uid, String query, bool ascending) {
    print(
        "ListTodoUseCase called with uid: $uid, query: $query, ascending: $ascending");
    return repository.getAll(uid, query!, ascending);
  }
}
