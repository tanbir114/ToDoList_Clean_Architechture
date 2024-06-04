import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do_list_clean_architecture/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../entities/todo.dart';

class ListTodoUseCase implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;
  ListTodoUseCase(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams) async {
    return await repository.getAll();
  }
}
