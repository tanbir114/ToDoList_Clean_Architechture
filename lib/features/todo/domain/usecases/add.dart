import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../entities/todo.dart';

class AddTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params todo) async {
    return await repository.add(todo.data);
  }
}
