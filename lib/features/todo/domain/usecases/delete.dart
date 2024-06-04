import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params todo) async {
    return await repository.delete(todo.data);
  }
}
