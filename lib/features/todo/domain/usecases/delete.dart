import 'package:dartz/dartz.dart';
import 'package:to_do_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../entities/todo.dart';

class DeleteTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params todo) async {
    return await repository.delete(todo.data);
  }
}
