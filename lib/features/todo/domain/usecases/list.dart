import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../entities/todo.dart';

class ListTodoUseCase implements UseCase<Stream<List<Todo>>, Params> {
  final TodoRepository repository;
  ListTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(Params params) {
    return repository.getAll(params.data);
  }
}
