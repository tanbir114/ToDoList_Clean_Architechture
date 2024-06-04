import 'package:dartz/dartz.dart';
import 'package:to_do_list_clean_architecture/features/authentication/domain/repositories/auth_repo.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../entities/user.dart';

class SignInUseCase implements UseCase<ToDoUser, Params<ToDoUser>> {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, ToDoUser>> call(Params todouser) async {
    return await repository.signIn(todouser.data);
  }
}
